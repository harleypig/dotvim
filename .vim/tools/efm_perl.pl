#!/usr/bin/perl

# This is shamelessly ripped from $VIMRUNTIME/tools/efm_perl.pl (which was last
# updated in 2001 according to the version history--but I'm willing to accept #
# that someone has probably made changes to it since then.) Check that file for
# details and historical information.

use strict;
use warnings;

( my $file = shift ) or die "No filename to check!\n";

my @lines = `perl -c $file 2>&1`;

my $errors = 0;

foreach my $line ( @lines ) {

    next if $line =~ /\"DB\:\:single\" used only once\: possible typo/;
    next if $line =~ /BEGIN failed--compilation aborted/;

    if ( my ( $message, $file, $lineno, $rest ) = $line =~ /^(.*)\sat\s(.*)\sline\s(\d+)(\.|,\snear\s\".*\"?)$/ ) {


      $errors++;
      $message .= $rest if ($rest =~ s/^,//);
      print "$file:$lineno:$message\n";

    }
}
