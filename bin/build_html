#!/usr/bin/perl

use strict;
use warnings;

use IPC::Run3::Simple;
use File::Find::Rule;
use File::Temp;
use Regexp::Common 'ANSIescape';

# Directory to save html files to
my $html_dir = './html';

# Doc files can be found in the runtimepath variable. See ':h help'. Dump the runtimepath to a temp file and read it in. Is there
# a way to get this info directly from vim?

my @doc_dirs = do {

  #my $fh = File::Temp->new;
  #my $tmpfile = $fh->filename;
  #
  # Thanks to John Little on vim_use for the pointer to redir.
  # https://groups.google.com/d/msg/vim_use/tGQdQX4MB68/kIhYPAMMsTgJ
  # Also to Christian Brabandt for the idea of using pipes to make the command easier to read.
  #my @cmd = ( 'vim', '-c', "redir! > $tmpfile | echo &rtp | redir END | q" );
  #my ( undef, $err, $syserr, $time ) = run3( \@cmd );
  #warn "Took $time seconds to run @cmd\n";
  #die "err: ($syserr) $err\n" if $syserr;
  #die "$err\n" if $err ne '' && $err ne 'Vim: Warning: Output is not to a terminal';
  #
  #map { "$_/doc" }
  #  grep { ! /^$/ }
  #    split /[,\s]+/, do { local $/ ; <$fh> };

  # Thanks to Christian Brabandt for the final solution.
  # https://groups.google.com/d/msg/vim_use/tGQdQX4MB68/kqP4mdR5hZsJ
  my @cmd = (qw( vim -u ~/.vimrc -Esc ), 'verbose echo &rtp|q' );
  my ( $out, $err, $syserr, $time ) = run3( \@cmd );

  warn "Took $time seconds to run @cmd\n";
  die "err: ($syserr) $err\n" if $syserr;
  die "out should be empty ($out)\n" if $out ne '';

  map { "$_/doc" } split /,/, $err;

};

# :h tags-file-format
# {tagname} TAB {tagfile} TAB {tagaddress}
# {tagfile}:{tagname} TAB {tagfile} TAB {tagaddress}
# {tagname} TAB {tagfile} TAB {tagaddress} {term} {field} ..

# The second format is obsolete, but I'm not going to worry about it until I run into it.

# We need to search for, and replace, three different bits of text in the help files:
#
# 'Keyword' with a link to the file and location. E.g., 'textwidth' would be replaced with
# '<a href="options.html#textwidth">textwidth</a>'.
#
# 'Keyword section' with a href location. E.g., the 'textwidth' section header in 'options.txt' would be replaced with
# <a name="'textwidth'"></a>'textwidth'
#
# 'Filename' with a link to the file. E.g, 'options.txt' would be replaced with <a href="options.html">options.txt</a>.

# The entry in the tags file for 'textwidth' looks like this
#
# 'textwidth'	options.txt	/*'textwidth'*
#
# This needs to be in the tag hash and looking like
#
# $tag{ "'textwidth'"   } = '<a href="options.html#'textwidth'">textwidth</a>';
# $tag{ "*'textwidth'*" } = '<a name="\'textwidth\'"></a>*\'textwidth\'*';
# $tag{ "options.txt"   } = '<a href="options.html">options.txt</a>';

my $keyword_tmpl  = '<a href="<<FILE>>.html#<<KEYWORD>>"><<KEYWORD>></a>';
my $section_tmpl  = '*<a name="<<KEYWORD>>"></a><<KEYWORD>>*';
my $filename_tmpl = '<a href="<<FILE>>.html"><<FILE>>.txt</a>';
my $html_tmpl     = q{<html>
<head>
  <title><<FILE>></title>
</head>
<body>
<pre><<CONTENT>></pre>
</body>
</html>};

my @tags_files = File::Find::Rule->name( 'tags' )->in( @doc_dirs );
my %tag;

my $tag = parse_tags_files( @tags_files );

my @doc_files = File::Find::Rule->name( '*.\.txt$' )->in( @doc_dirs );
#my %doc_file; @doc_file{ @doc_files } = '' x @doc_files;

parse_doc_file( $_, $tag ) for @doc_files;

sub parse_tags_files {

  my %tag;

  for my $tags_file ( @_ ) {

    open my $TAGS, '<', $tags_file or do {
      warn "Unable to open $tags_file ($!), skipping ...\n";
      next;
    };

    while ( defined( my $line = <$TAGS> ) ) {

      chomp $line;

      my ( $tagname, $tagfile, $tagaddress ) = split /\s/, $line, 3;

      # ignore special tags
      next if $tagname =~ /^!_TAG_/;

      die "tagname should not be blank at $tags_file line $.\n"    if $tagname eq '';
      die "tagfile should not be blank at $tags_file line $.\n"    if $tagfile eq '';
      die "tagaddress should not be blank at $tags_file line $.\n" if $tagaddress eq '';
      die "$tagname already exists at $tags_file line $.\n"        if exists $tag{ $tagname };

      # I'm just curious, do any of these ever have whitespace?
      warn "tagname ($tagname, $tags_file) has whitespace\n" if $tagname =~ /\s/;
      warn "tagfile ($tagfile) has whitespace\n"             if $tagfile =~ /\s/;
      warn "tagaddress ($tagaddress) has whitespace\n"       if $tagaddress =~ /\s/;

      $tagaddress =~ s/;".*$//;   # We don't need to handle any extended information.
      $tagaddress =~ s/\\\\/\\/g; # Doubled backslashes need to be fixed.
      $tagaddress =~ s/^\///;

      $tagfile    =~ s/\.txt$//;

      my %hash = ( KEYWORD => $tagname, FILE => $tagfile );

      my $tmpl = $tagname =~ /\.txt$/ ? $filename_tmpl : $keyword_tmpl;
      $tmpl =~ s/<<([^>]+)>>/$hash{ $1 }/g;
      $tag{ $tagname } = $tmpl;

      ( $tmpl = $section_tmpl ) =~ s/<<([^>]+)>>/$hash{ $1 }/g;
      $tag{ $tagaddress } = $tmpl;

    }
  }

  return \%tag;

}
