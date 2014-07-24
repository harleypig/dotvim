#!/usr/bin/perl

# Thanks to:
#
# http://blogs.perl.org/users/ovid/2011/01/warningsunused-versus-ppi.html for
# the 'warnings::unused' trick.
#
# https://github.com/Ovid/DB--Color.git for the 'circular::require' trick

use strict;
use warnings FATAL => 'all';
use autodie;

use Cwd;
use File::Basename;
use IPC::Run3::Simple;

die "Too many arguments!\n"
  if scalar @ARGV > 1;

my $file = shift @ARGV
  or die "No filename to check!\n";

my ( $perldoc, $efm, $err, $syserr, @checks, @modules );

# Grab custom instructions for this file from the file.

# Any line that begins with no spaces and looks like
#
# ## efm skip circular unused lint
#
# will skip the listed tests. Currently known tests are:

my @tests = qw( circular indirect lint method uninit unused );
my %test; @test{ @tests } = ( 1 ) x @tests;

# Any line that begins with
#
# ## efm debug
#
# will turn on debugging messages. Anything after debug
# will be ignored.

## efm debug

# Any line that begins with
#
# ## efm modules
#
# will add the listed modules to the -c call. E.g.,
#
# ## efm modules Module::Name
#
# will add -MModule::Name to the -c call.

( $efm, $err, $syserr ) = run3( [ 'grep', '^## efm ', $file ] );

my $DEBUG = 0;

if ( ! $syserr ) {  # 0 = success because we're dealing with the shell
  for my $line ( split /\n+/, $efm ) {

    if ( $line =~ /^## efm\s+debug/ ) {

      $DEBUG++;

    } elsif ( $line =~ s/^## efm\s+skip\s+// ) {

      delete $test{ $_ } for split /\s+/, $line;

    } elsif ( $line =~ s/^## efm\s+modules\s+// ) {

      push @modules, split /\s+/, $line;

    }
  }

  if ( @modules ) {

    @modules = map { "-M$_" } @modules;

  }
} ## end if ( ! $syserr )

# Error messages to be skipped.
my @skip = (

  '"DB::single" used only once: possible typo',
  'BEGIN failed--compilation aborted',

);

my $skip = join q{|}, @skip;

# Grab perldoc location
( $perldoc, $err, $syserr ) = run3( [qw( which perldoc )] );

if ( ! $syserr ) {

  my @perldoc = ( $perldoc, '-l' );

  # Note: Most of the following modules need to be installed, most are not
  # included in core.

  if ( exists $test{ lint } ) {

    ( undef, undef, $syserr ) = run3( [ @perldoc, 'B::Lint::StrictOO' ] );

    push @checks, '-MB::Lint::StrictOO'
      if ! $syserr;

    #    ( undef, undef, $syserr ) = run3( [ @perldoc, 'B::LintSubs'  ] );
    #
    #    push @checks, '-MO=LintSubs'
    #      if ! $syserr;

    push @checks, '-MO=Lint,none,magic-diamond,context,bare-subs,regexp-variables,oo';

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
    push @checks, '-Muninit'
      if ! $syserr;

  }
} ## end if ( ! $syserr )

# Naive attempt to include working module libraries.
my @includes = qw( -I ./lib -I ./lib/auto );

my $cmd = [ 'perl', @includes, @checks, '-c', $file ];

run3( {

    'cmd'    => $cmd,
    'stdout' => \$err,
    'stderr' => \my @errors,
    'syserr' => \$syserr,

} );

for my $error ( @errors ) {

  next if $error =~ /$skip/;
  print "$error\n";

}
