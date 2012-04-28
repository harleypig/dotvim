#
# makelatex.awk - creates LaTeX documentation for Vim 6.1
# 
# Author: Lubomir Host 'rajo' <host8 AT keplerDOTfmphDOTunibaDOTsk>
#

# $Id: makelatex.awk,v 1.5 2002/04/12 03:39:00 host8 Exp $

# function read_example() {{{
function read_example(substit, str)
{
	in_example = 1; count = 0;
	while (in_example) {
		getline;
		gsub(/^\t/, "    ");
	#if (substit) gsub("\t", " ");
		if ( $0 ~ /^ /) {
			in_example = 1; count += 1;
			print;
		}
		if ( $0 ~ /^</) {         # tips.txt:341 -- '^<$'
			in_example = 0;       # fold.txt:425 -- '^<		Note the use...'
			printf("\\end{verbatim}%s %% MARK1\n", str);
			sub(/^</, "");
		}
		if ( $0 ~ /^[a-zA-Z]/) {
			in_example = 0;
			printf("\\end{verbatim}%s %% MARK2\n", str);
		}
		if ( $0 ~ / >$/) { # next example begin after previous example
			gsub(/ >$/, ""); print prevent_chars($0); # print last line withouth '>' character
				printf("{\\footnotesize %% MARK3\n\\begin{verbatim}\n");
			in_example = 1; count = 0;
		}
	}
#	print;
} # }}} read_example() 

# function prevent_chars() {{{
function prevent_chars(tmp_str)
{
	str = tmp_str;
	gsub(/_/, "\\_", str);
	gsub(/#/, "\\#", str);
	gsub(/\^/, "\\^", str);
	gsub(/ \$ /, " \$ ", str); # usr_03.txt:527
	gsub(/&/, "\\\&", str);
	return str;
} # }}} prevent_chars()

# function prevent_special_label() {{{
function prevent_special_label(tmp_str)
{
	str = tmp_str;
	
	gsub(/_/, "Cursor", str);

	return str;
} # }}} prevent_special_label()

# function print_verbatim() {{{
function print_verbatim(str)
{
		sub(/^\t/, "    ", str)
		gsub(/\t/, "        ", str)
		print str;
} # }}} print_verbatim()
// {
	# remember $0 as current_line
	current_line = $0;
}

# remove lines 'VIM REFERENCE MANUAL    by Bram Moolenaar'
/VIM REFERENCE MANUAL/ { next; }
/VIM USER MANUAL/ { next; }

# Vim user manual: screens {{{
/^	\+----------------------------/ {
	printf("{\\footnotesize %% MARK4\n\\begin{verbatim}\n");
	gsub(/^\t/, "    ");
	print;
	in_example = 1; count = 0;
	while (in_example) {
		getline;
		gsub(/^\t/, "    ");   # remove left line
		gsub(/\t/, "        ");
#		gsub(/\|$/, "");   # remove right line
#		gsub(/\t/, "        ");
#		if (/^[ ]*\+---*/) { # remove bottom line
#			printf("\\end{verbatim}\n}\n");
#			next;
#		}
		if ( $0 ~ /^ /) {
			in_example = 1; count += 1;
			print;
		}
		else {
			print;
			in_example = 0;
		}
	}
	printf("\\end{verbatim}\n}%% MARK5\n");
	next;
}
# }}}

# Vim help files begin with '^\*help.txt\*' {{{
/^\*/ {
	n = split($0, a, "*");
	printf("\\vimhelpSection{%s}%% MARK6\n", prevent_chars(a[2]));
	next;
}
# }}} Vim help lines

# Example {{{
/ >$/ { 
	gsub(/ >$/, ""); print prevent_chars($0); # print last line withouth '>' character
	printf("{\\footnotesize %% MARK7\n\\begin{verbatim}\n");
	read_example(0, " }");
#	next;
}
# must be after MARK7(+MARK2)
/^Next chapter:/ { next; }
/^Copyright:/ { next; }

/^>$/ { 
	gsub(/>$/, ""); print; # print last line withouth '>' character
	printf("{\\footnotesize %% MARK8\n\\begin{verbatim}\n");
	read_example(0, " }");
#	next;
} # }}} Example

# Star {{{
# line with '*vimhelpStar*'
/\*[^ \*]+\*/ {
	line = $0; # remember line
	gsub(/\*[^ \*]+\*/, "\\vimhelpStar{&}", line);
	gsub(/\\vimhelpStar{\*/, "\\vimhelpStar{", line);
	gsub(/\*}/, "}", line);
	sub(/\\vimhelpStar*/, "\\begin{flushright} \\mbox{ &", line);
	if (line ~ / >$/) { # \vimhelpExample{}
		sub(/ >$/, " } \\end{flushright} {\\footnotesize %% MARK9\n\\begin{verbatim}\n", line);
		print prevent_chars(line);
		read_example(0, " }");
#		next;
	}
	else {
		sub(/$/, " } \\end{flushright}%% MARK10\n", line);
		print line;
		next;
	}
}
# }}} Star

# end of example
/<$/ { # end of example
	if ($0 ~ /first <$/) { print; next; } # usr_04.txt:165
	gsub(/<$/, "");
	printf("\\end{verbatim} }%% MARK11\n");
}

# NotInVi {{{
/\{not in Vi\}/ {
	gsub(/\{not in Vi\}/, "\\vimhelpNotInVi ");
} # }}} NotInVi

# Parenthises {{{
/\{\{\{/ {
	gsub(/\{\{\{/, "\\vimhelpMarkerFirst ");
}
/\}\}\}/ {
	gsub(/\}\}\}/, "\\vimhelpMarkerLast ");
}
/\{.*\}/ {
	gsub(/\{/, "\\vimhelpParenthises{");
} # }}} Parenthises

# Section


# Modeline {{{
/^[ 	]vim:/ {
	printf("\\vimhelpModeline{}\n", $0);
	next;
} # }}} Modeline

# Separator + Subsection {{{
/^=================/ {
	printf("\n\\vimhelpSeparator %% MARK12\n\n");
	getline;
	if (/^$/) { # if there is empty line, next lines are  '^Next chapter:',  '^Copyright:'
		getline;
		if (/^Next chapter:/) { } else { print; }
		getline; getline; # one empty line and then '^Copyright:'
		if (/^Copyright:/) { } else { print; }	
		next;
	}
	if (/^[ 	]*vim:/) { # there is a vim modeline, 
		printf("\\vimhelpModeline{}%% MARK13\n", $0);
		next;
	}
	if (/^\*/) { # VIM USER MANUAL have a different section (usr_*.txt files)
		sub(/^\*[0-9\.]+\*[ 	]+/, ""); # remove numbering of chapters from line
	}
	else {
		gsub(/^([0-9]\.[ 	])/, "");
	}
	n = split($0, a, "*");
	if (n > 1) {
		printf("\\vimhelpSubsection{%s}%% MARK14\n\\begin{flushright}\n\t\\mbox{ ", a[1]);
		for (i = 2; i <= n; i++) {
			if (a[i] !~ /^[ 	]+$|^$/) {  # white chars or empty
				printf("\\vimhelpStarSpecial{%s}{%s}\n",
						prevent_chars(a[i]),
						prevent_special_label(a[i]));
			}
		}
		printf("\t}%% MARK15 -- end of mbox\n\\end{flushright}\n");
	}
	else {
		printf("\\vimhelpSubsection{%s}%% MARK16\n", $0);
	}
		
	next;
} # }}} Separator + Subsection

# Subsubsection {{{
/^[A-Z ]+[ ]*\~$/ {
	sub(/[ ]*\~$/, "");
	# Convert '^UPPER CASE TEXT' --> '^Upper case text'
	printf "\\vimhelpSubsubsection{%s", toupper(substr($0, 1, 1));
	printf "%s}%% MARK 17\n", tolower(substr($0, 2));
	next;
}
# }}} Subsubsection

# Pipe {{{
/\|[^ ]+\|/ {
#gsub(/\|[^ ]+\|/, "\\vimhelpPipe{\\verb&}");
	for (i=1; i <=NR; i++) {
		if ($i ~/\|[^ ]+\|/) {
			gsub(/\|/, "", $i);
		}
	}

#gsub(/\|/, "");
}
# }}} Pipe

# Quote


# Note
# Table
# NotInVi
# Paragraph
# Special

// {
	# remember last line;
	last_line = current_line;

	gsub(/\.\*\[]\^%\/\\\?~\$ /, "\\verb & %% MARK18\n"); # usr_03.txt:335
	$0 = prevent_chars($0);
	gsub(/"}}}"/, "\"\\}\\}\\}\"");
	gsub(/{]}/, "{\\]\\}");
	gsub(/'{'/, "'\\{'");
	gsub(/'}'/, "'\\}'");
	gsub(/%/, "\\\%");
	gsub(/{\[/, "{\\[");
	gsub(/\\E /, "\\verb & %% MARK19\n");
	gsub(/\$VIMRUNTIME/, "\\\&");
	gsub(/\$VIM /, "\\\&");
	gsub(/\$VAR/, "\\\&");
	gsub(/\$HOME/, "\\\&");   # usr_05.txt:352
	gsub(/\$TERM/, "\\\&");   # usr_05.tx6:70
	gsub(/\$"/, "\\$\"");     # usr_03.txt:80,95-98
	gsub(/\$\t/, "\$\t"); # usr_10.txt:64,112
	gsub(/"\^"/, "\"\\^\"");  # usr_03.txt:83
	gsub(/\$$/, "\\$");       # usr_03.txt:92
	gsub(/"\\[^ ]+"/, "\\verb & %% MARK20\n"); # usr_03.txt:412 usr_05.txt:278

	# terminal escape codes
#gsub(/\^\[ /, "\\^[ ");
		gsub(/[^\\]\^\[\[\?47h/, "\^[[?47h %% MARK21\n"); # tips.txt:139
		gsub(/[^\\]\^\[\[\?47l/, "\^[[?47l %% MARK22\n");

	print;
}

# vim: cindent fdm=marker fdc=3
