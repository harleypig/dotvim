#!/usr/bin/perl

use strict;
use warnings;

use IPC::Run3::Simple;
use File::Find::Rule;

# Doc files can be found in the runtimepath variable. See ':h help'.  Dump the runtimepath to a temp file and read it in.  Is there
# a way to get this info directly from vim?

my @dirs = do {

  my $temp_file = '/tmp/rtp';
  my @cmd = ( 'vim', '-c', "call system( 'echo ' . &rtp . ' > $temp_file' )", '-c', 'q' );
  my ( undef, $err, $syserr ) = run3( \@cmd );
  die "syserr: $syserr\n" if $syserr;
  die "$err\n" unless $err eq 'Vim: Warning: Output is not to a terminal';

  local $/;
  open my $FH, '<', $temp_file or die "Can't open $temp_file: $!\n";
  map { "$_/doc" } split /,|\s/, <$FH>;

};

# :h tags-file-format
# {tagname} TAB {tagfile} TAB {tagaddress}
# {tagfile}:{tagname} TAB {tagfile} TAB {tagaddress}

# Load the known tags into a hash of the form
# %tag = ( tagname => [ tagfile, tagaddress ] );

my @tags = File::Find::Rule->name( 'tags' )->in( @dirs );
my %tag;

for my $tagfile ( @tags ) {

  open my $TAG, '<', $tagfile or do {
    warn "Unable to open $tagfile ($!), skipping ...\n";
    next;
  };

  while ( defined( my $tag = <$TAG> ) ) {

    my @tag = split /\s/, $tag;
    die "$tag[0] already exists ( @{ $tag{ $tag[0] } } )\n" if exists $tag{ $tag[0] };

    $tag{ shift @tag } = \@tag;

  }

}

print '?';
