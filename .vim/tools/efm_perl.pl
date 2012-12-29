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

my ( $perldoc, $efm, $err, $syserr, @checks );

my $output_format = "%.1s:$file:%d:%s\n";

# Grab custom instructions for this file from the file.

# Any line that begins with no spaces and looks like
#
# ## efm skip circular unused lint
#
# will skip the listed tests. Currently known tests are:

my @tests = qw( circular indirect lint method perlcritic uninit unused );
my %test; @test{ @tests } = ( 1 ) x @tests;

#printwarn( 1, 'testing warnings' );

# Any line that begins with
#
# ## efm debug
#
# will turn on debugging messages. Anything after debug
# will be ignored.

## efm debug

( $efm, $err, $syserr ) = run3( [ 'grep', '^## efm ', $file ] );
printerr( 1, $err ) if $err;

my $DEBUG = 0;

if ( ! $syserr ) { # 0 = success because we're dealing with the shell
  for my $line ( split /\n+/, $efm ) {

    if ( $line =~ /^## efm\s+debug/ ) {

      $DEBUG++;

    } else {

      $line =~ s/^## efm\s+skip\s+//;

      delete $test{ $_ }
        for split /\s+/, $line;

    }
  }
}

if ( $DEBUG ) {

  my $tests = join ' ', sort keys %test;
  printinfo( "using $tests" ) if $DEBUG;

}

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

# Grab perldoc location
( $perldoc, $err, $syserr ) = run3( [qw( which perldoc )] );
printerr( 1, $err ) if $err;

if ( ! $syserr ) {

  my @perldoc = ( $perldoc, '-l' );

  # Note: Most of the following modules need to be installed, most are not
  # included in core.

  if ( exists $test{ lint } ) {

    ( undef, undef, $syserr ) = run3( [ @perldoc, 'B::Lint::StrictOO' ] );

    push @checks, '-MB::Lint::StrictOO'
      if ! $syserr;

    push @checks, '-MO=Lint,all,oo';

  }

  my %pragma = (

    circular => '-circular::require',
    indirect => '-indirect',
    method   => 'warnings::method',
    unused   => 'warnings::unused',

  );

  for my $pragma ( sort keys %pragma ) {

    next unless exists $test{ $pragma };

    my $module = $pragma{ $pragma };
    ( my $m = $module ) =~ s/^-?//;
    my $cmd = [ @perldoc, $m ];
    ( undef, undef, $syserr ) = run3( $cmd );

    push @checks, "-M$module"
      if ! $syserr;

  }

  # uninit is not included in 5.10 and later
  if ( $] < 5.010 && exists $test{ uninit } ) { ## no critic qw( ValuesAndExpressions::ProhibitMagicNumbers )

    ( undef, $err, $syserr ) = run3( [ @perldoc, 'uninit' ] );
    printerr( 1, $err ) if $err;
    push @checks, '-Muninit'
      if ! $syserr;

  }
} ## end if ( ! $syserr )

my $checks = join q{ }, @checks;

my ( $message, $extracted_file, $lineno, $rest );

my $cmd = [ 'perl', '-I', $dir, '-I', $cwd, @checks, '-c', $file ];
printinfo( "@$cmd" ) if $DEBUG;

run3( {

    'cmd'    => $cmd,
    'stdout' => \$err,
    'stderr' => \my @errors,
    'syserr' => \$syserr,

} );

printerr( 1, "stdout - $err" ) if $err;

my $critique = exists $test{ perlcritic } || 0;
my $err_count = 0;

for my $error ( @errors ) {

  next if $error =~ /$skip/;
  $error =~ s/([()])/\\$1/g;

  if ( ( $message, $extracted_file, $lineno, $rest ) = $error =~ /^$error_rx$/ ) {

    $message .= $rest if ( $rest =~ s/^,?\snear// );
    printerr( $lineno, $message );
    $critique = 0;
    $err_count++;

  }
}

printinfo( "$err_count error(s)" ) if $DEBUG;

# If we have errors, we're not going to worry about perlcritic
if ( $critique ) {

  my $perlcritic;
  ( $perlcritic, $err ) = run3( [qw( which perlcritic )] );
  printerr( 1, $err ) if $err;

  my $format = 'W:%f:%l:%m (near %r) %p\n'; ## no critic qw( ValuesAndExpressions::RequireInterpolationOfMetachars )
  $cmd = [ $perlcritic, '--quiet', '--verbose', $format, $file ];
  printinfo( "@$cmd" ) if $DEBUG;

  run3( {

      'cmd'    => $cmd,
      'stdout' => \my @critiques,
      'stderr' => \$err,

  } );

  print "$_\n" for @critiques;
  printinfo( scalar @critiques . 'critiques(s)' ) if $DEBUG;

} ## end if ( $critique )

sub printline { printf $output_format, @_ }

sub printinfo { printline( 'I', 1, @_ ) }
sub printwarn { printline( 'W', @_ ) }
sub printerr  { printline( 'E', @_ ) }
