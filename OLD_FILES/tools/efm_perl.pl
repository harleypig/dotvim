#!/usr/bin/env perl

# # efm debug
# # efm skipall
# # efm modules CGI
# # efm skip unused pedantic-maybe_const lint-context

#---------------------------------------------------
# Any line that begins with no spaces and looks like
#
# ## efm skip circular unused lint
#
# will skip the listed tests. Currently known tests are stored in the @tests
# variable in the get_directives sub.
#
# If you have
#
# ## efm skipall
#
# then all tests will be skipped.

#---------------------------------------------------
# Any line that begins with no spaces and looks like
#
# ## efm debug
#
# will turn on debugging messages. Anything after debug
# will be ignored.

#---------------------------------------------------
# Any line that begins with no spaces and looks like
#
# ## efm modules
#
# will add the listed modules to the -c call. E.g.,
#
# ## efm modules Module::Name
#
# will add -MModule::Name to the -c call.

#---------------------------------------------------
# Any line that begins with no spaces and looks like
#
# ## efm libs
#
# will add the listed directories to the -c call. E.g.,
#
# ## efm includes path/to/lib
#
# will add -I path/to/lib to the -c call.

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
use IPC::Run3::Simple;
use Try::Tiny;

die "Too many arguments!\n"
  if scalar @ARGV > 1;

my $file = shift @ARGV
  or die "No filename to check!\n";

known_tests()
  if $file eq 'dumptests';

die "$file is not a file\n"
  unless -f $file;

die "$file is not readable\n"
  unless -r _;

our $DEBUG = 0;

##############################################################################

my ( $includes, $modules ) = get_directives();

my $cmd = [ perl(), @$includes, @$modules, '-c', $file ];

run3( {
    'cmd'    => $cmd,
    'stdout' => \my $err,
    'stderr' => \my @errors,
    'syserr' => \my $syserr,
} );

$DEBUG && warn "@$cmd at efm_perl.pl line 1\n";

my $skip = skip_error_messages();

for my $error ( @errors ) {
  # Skip any errors reported that aren't in the file we're checking.
  next unless $error =~ /$file/;

  # Skip any errors we want to ignore.
  next if $error =~ /$skip/;

  print "$error\n";
}

##############################################################################

# Make external call
sub call {
  my ( $cmd ) = @_;

  my ( $result, $err, $syserr ) = run3( $cmd );

  my $msg;

  $msg .= "Unexpected error: $syserr\n"
    if $syserr;

  $msg .= "Error: $err\n"
    if $err;

  die $msg if $msg;

  return $result;
} ## end sub call

# Grab perldoc location.
{
  my $perldoc;
  sub perldoc { return $perldoc ||= call( [qw( which perldoc )] ) }
}

# Grab perl to be used based on environment.
{
  my $perl;
  sub perl { return $perl ||= call( [qw( which perl )] ) }
}

# Check if module is installed
sub module_installed {
  my ( $module ) = @_;

  try {
    my $found_module = call( [ perldoc(), '-l', $module ] );
    $DEBUG && warn "$module is installed ($found_module)";
    return 1;
  }
  catch {
    if ( /No documentation/ ) {
      $DEBUG && warn "$module is not installed";
      return;
    }

    die "$_\n";
  }
} ## end sub module_installed

# Error messages to be skipped.
sub skip_error_messages {
  return join q{|}, ( '"DB::single" used only once: possible typo', 'BEGIN failed--compilation aborted', );
}

# Display known tests.
sub known_tests {

  my @tests = keys %{ tests() };
  my @lint_tests = keys %{ lint_tests() };
  my @pedantic_tests = keys %{ pedantic_tests() };

  print "$_\n" for sort ( @tests, @lint_tests, @pedantic_tests );
  exit;

}

##############################################################################

sub tests {
  return {
    circular       => '-circular::require',
    indirect       => '-indirect',
    lint           => 'B::Lint',
    lintsubs       => 'B::LintSubs',
    method         => 'warnings::method',
    pedantic       => 'warnings::pedantic',
    regexrecompile => 'warnings::regex::compile',
    uninit         => 'uninit',
    unused         => 'warnings::unused',
  };
}

##############################################################################

sub lint_tests {
  my @lint_tests = qw(
    bare-subs context dollar-underscore implicit-read implicit-write
    magic-diamond oo private-names regexp-variables undefined-subs
  );

  @lint_tests = map { "lint-$_" } @lint_tests;

  my %lint_test; @lint_test{ @lint_tests } = ( 1 ) x @lint_tests;

  return \%lint_test;
}

sub check_lint_tests {
  my ( $lint_module, $tests ) = @_;

  if ( module_installed( $lint_module ) ) {
    # If B::LintStrictOO is not installed, remove lint-oo from available tests.
    if ( exists $tests->{ 'lint-oo' } ) {
      delete $tests->{ 'lint-oo' }
        unless module_installed( 'B::LintStrictOO' );
    }

    my $use_oo = delete $tests->{ 'lint-oo' };

    my $remaining_tests = scalar keys %$tests;
    my $total_tests     = scalar keys %{ lint_tests() };

    $total_tests--; # Account for having removed lint-oo.

    # If all tests remain in $tests, then use all.
    $tests = { all => 1 }
      if $remaining_tests == $total_tests;

    # If no tests remain in $tests, then use none.
    $tests = { none => 1 }
      if $remaining_tests <= 1;

    $tests->{ 'lint-oo' } = 1
      if $use_oo;

    my $options = join ',', map { s/lint-//; $_ } sort keys %$tests;

    return "O=Lint,$options";
  } ## end if ( module_installed...)
} ## end sub check_lint_tests

##############################################################################

sub pedantic_tests {

  my @pedantic_tests = qw(

    maybe_const ref_assignment sort_prototype void_close void_grep void_print

  );

  @pedantic_tests = map { "pedantic-$_" } @pedantic_tests;

  my %pedantic_test; @pedantic_test{ @pedantic_tests } = ( 1 ) x @pedantic_tests;

  return \%pedantic_test;

}

sub check_pedantic_tests {

  my ( $module, $tests ) = @_;

  if ( module_installed( $module ) ) {

    # If all tests remain in %pedantic_test then no need for explicitly
    # calling tests.

    # If no tests remain in %pedantic_test then we can skip this test
    # entirely.

    my $remaining_tests = scalar keys %$tests;
    my $total_tests     = scalar keys %{ pedantic_tests() };

    return $module
      if $remaining_tests == $total_tests;

    if ( $remaining_tests != 0 ) {

      my $options = join ',', map { s/pedantic-//; $_ } sort keys %$tests;
      return "$module=$options";

    }
  } ## end if ( module_installed...)

  return;

} ## end sub check_pedantic_tests

##############################################################################



##############################################################################

# Grab custom instructions for this file from the file.

sub get_directives {

  my $efm = '';

  try {

    $efm = call( [ 'grep', '^## efm ', $file ] );

  }
  catch {

    /Error:/ ? $DEBUG && "No efm lines found.\n" : do { die "$_\n" };

  };

  my $test          = tests();
  my $lint_test     = lint_tests();
  my $pedantic_test = pedantic_tests();

  # Naive attempt to include default working module libraries.
  my @includes = qw( ./lib ./lib/auto );

  my ( @modules, @check_modules );

  for my $line ( split /\n+/, $efm ) {
    if ( $line =~ /^## efm\s+debug/ ) {

      $DEBUG++;

    } elsif ( $line =~ s/^## efm\s+skipall// ) {

      $test = {};

    } elsif ( $line =~ s/^## efm\s+skip\s+// ) {

      for my $skip ( split /\s+/, $line ) {

        delete $test->{ $skip };
        delete $lint_test->{ $skip };
        delete $pedantic_test->{ $skip };

      }
    } elsif ( $line =~ s/^## efm\s+modules\s+// ) {

      push @check_modules, split /\s+/, $line;

    } elsif ( $line =~ s/^## efm\s+includes\s+// ) {

      push @includes, split /\s+/, $line;

    }
  } ## end for my $line ( split...)

  # Special handling for lint test ...
  if ( exists $test->{ lint } ) {

    my $lint = check_lint_tests( delete $test->{ lint }, $lint_test );

    push @modules, $lint
      if defined $lint;

  } ## end if ( exists $test...)

  # Special handling for pedantics tests ..
  if ( exists $test->{ pedantic } ) {

    my $pedantic = check_pedantic_tests( delete $test->{ pedantic }, $pedantic_test );

    push @modules, $pedantic
      if defined $pedantic;

  }

  # uninit is not included in 5.10 and later
  delete $test->{ uninit }
    if exists $test->{ uninit } && $] >= 5.010;

  # Check if test modules are installed ...
  for my $m ( sort keys %$test ) {

    my $module = $test->{ $m };
    ( my $check_module = $module ) =~ s/^-?//;

    push @modules, $module
      if module_installed( $check_module );

  }

  # Check if requested modules are installed ...
  for my $module ( @check_modules ) {

    push @modules, $module
      if module_installed( $module );

  }

  @includes = map { ( '-I', $_ ) } @includes;
  @modules = map { "-M$_" } @modules;

  return \@includes, \@modules;

} ## end sub get_directives
