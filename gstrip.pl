#!/usr/bin/perl -w 
use strict;
use warnings;

# ANSI color codes
my $staged = "\e[32m";
my $unstaged = "\e[31m";
my $default = "\e[0m";

# Regexps
my $filename_regex = qr/^\t(?:new\ file:\s*|deleted:\s*|modified:\s*|)(.*)$/;
my $staged_regex = qr/^Changes to be committed\:$/;
my $unstaged_regex = qr/^Changes not staged for commit\:$/;
my $untracked_regex = qr/^Untracked files\:$/;
my $empty_line = qr/^\n$/;

my @filenames = ();
my $status;
my $empty_line_count = 0;

sub main {
  while (<>) {
    if($_ =~ $filename_regex) {
      push @filenames, $1;

    } elsif($_ =~ $staged_regex) {
      print_empty_lines();
      print $default."$_";

    } elsif($_ =~ $unstaged_regex) {
      if(@filenames) {
        print "\t".array_to_string($staged, @filenames);
        @filenames = ();
      }
      print_empty_lines();
      print $default."$_";

    } elsif($_ =~ $untracked_regex) {
      if(@filenames) {
        print "\t".array_to_string($unstaged, @filenames);
        @filenames = ();
      }
      print_empty_lines();
      print $default."$_";

    } elsif($_ =~ $empty_line) {
      $empty_line_count++;

    } else {
      print_empty_lines();
      print $default."$_";
    }
  }

  if(@filenames) {
    print "\t".array_to_string($unstaged, @filenames);
    @filenames = ();
  }
  print_empty_lines();
}

sub array_to_string {
    my ($color, @array) = @_;
    # my $text = $color."\t";
    my $text = "$color";

    foreach my $element (@array) {
      $text .= escape_spaces($element)." ";
    }
    $text .= "\n";
    return $text;
}

# Replace spaces with the escape character
sub escape_spaces {
    my ($input_string) = @_;
    $input_string =~ s/ /\\ /g;
    return $input_string;
}

sub print_empty_lines {
 for my $count (1..$empty_line_count) {
    print "\n";
  }
  $empty_line_count = 0;
}

main();