#!/usr/bin/perl

# This is shamelessly ripped from $VIMRUNTIME/tools/efm_perl.pl (which was last
# updated in 2001 according to the version history--but I'm willing to accept
# that someone has probably made changes to it since then.) Check that file for
# details and historical information.

# Since I can only install this file in systems I'm able to install whatever
# perl modules I want, I'm going to use some modules that make things a little
# easier.

# Thanks to:
#
# http://blogs.perl.org/users/ovid/2011/01/warningsunused-versus-ppi.html for
# the 'warnings::unused' trick.
#
# https://github.com/Ovid/DB--Color.git for the 'circular::require' trick
#
# http://blogs.perl.org/users/ovid/2012/07/integrating-perlcritic-and-vim.html
# for the idea of separating perlcritic out of the perl -c test.

use 5.008;

use strict;
use warnings;
use autodie;

use Cwd;
use File::Basename;
use IPC::Run3::Simple;

die "Too many arguments!\n"
  if @ARGV > 1;

my $file = shift
  or die "No filename to check!\n";

# Naive attempt to include working module libraries.
my $dir = dirname( $file ) . '/lib';
my $cwd = cwd() . '/lib';

my $error_rx = qr{(.*)\sat\s(.*)\sline\s(\d+)([.]|,?\snear\s["'].*["']?)};

# Error messages to be skipped.
my @skip = (

  '"DB::single" used only once: possible typo',
  'BEGIN failed--compilation aborted',

);

my $skip = join q{|}, @skip;

my ( $perldoc, $err, $syserr, @checks );

( $perldoc, $err, $syserr ) = run3( [qw( which perldoc )] );
warn "$err\n" if $err;

if ( ! $syserr ) {  # 0 = success because we're dealing with the shell

  my @perldoc = ( $perldoc, '-l' );

  # Note: Most of the following modules need to be installed, most are not
  # included in core.

  ( undef, undef, $syserr ) = run3( [ @perldoc, 'B::Lint::StrictOO' ] );

  push @checks, '-MB::Lint::StrictOO'
    if ! $syserr;

  push @checks, '-MO=Lint,all,oo';

  my @pragmas = qw( -circular::require -indirect warnings::method warnings::unused );

  for my $pragma ( @pragmas ) {

    ( my $p = $pragma ) =~ s/^-?//;
    my $cmd = [ @perldoc, $p ];
    ( undef, undef, $syserr ) = run3( $cmd );

    push @checks, "-M$pragma"
      if ! $syserr;

  }

  # uninit is not included in 5.10 and later
  if ( $] < 5.010 ) { ## no critic qw( ValuesAndExpressions::ProhibitMagicNumbers )

    ( undef, $err, $syserr ) = run3( [ @perldoc, 'uninit' ] );
    warn "$err\n" if $err;
    push @checks, '-Muninit'
      if ! $syserr;

  }
} ## end if ( ! $syserr )

my $checks = join q{ }, @checks;

my ( $message, $extracted_file, $lineno, $rest );

my $cmd = [ 'perl', '-I', $dir, '-I', $cwd, @checks, '-c', $file ];

run3( {

    'cmd'    => $cmd,
    'stdout' => \$err,
    'stderr' => \my @errors,
    'syserr' => \$syserr,

} );

warn "stdout: $err\n" if $err;

my $critique = 1;

for my $error ( @errors ) {

  next if $error =~ /$skip/;
  $error =~ s/([()])/\\$1/g;

  if ( ( $message, $extracted_file, $lineno, $rest ) = $error =~ /^$error_rx$/ ) {

    $message .= $rest if ( $rest =~ s/^,?\snear// );
    print "$file:$lineno:$message\n";
    $critique = 0;

  }
}

# If we have errors, we're not going to worry about perlcritic
if ( $critique ) {

  my $perlcritic;
  ( $perlcritic, $err ) = run3( [qw( which perlcritic )] );
  warn "$err\n" if $err;

  my $format = '%f:%l:%m (near %r) Severity: %s %p\n'; ## no critic qw( ValuesAndExpressions::RequireInterpolationOfMetachars )
  $cmd = [ $perlcritic, '--quiet', '--verbose', $format, $file ];

  run3( {

      'cmd'    => $cmd,
      'stdout' => \my @critiques,
      'stderr' => \$err,

  } );

  print "$_\n" for @critiques;

} ## end if ( $critique )
