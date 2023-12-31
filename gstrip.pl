#!/usr/bin/perl -w 
use strict;
use warnings;

# ANSI color codes
my $staged = "\e[32m";
my $unstaged = "\e[31m";
my $default = "\e[0m";

my $new_regex = qr/^\t(?:new\ file:\s*)(.*)$/;
my $modified_regex = qr/^\t(?:deleted:\s*)(.*)$/;
my $deleted_regex = qr/^\t(?:modified:\s*)(.*)$/;
my $untracked_regex = qr/^\t(?:)(.*)$/;

my @new = ();
my @modified = ();
my @deleted = ();
my @untracked = ();
my @filenames = ();

# Main subroutine
sub main {
  while (<>) {
    if($_ =~ $new_regex) {
      push @new, $1;
      push @filenames, $1;

    } elsif($_ =~ $modified_regex) {
      push @modified, $1;
      push @filenames, $1;

    } elsif($_ =~ $deleted_regex) {
      push @deleted, $1;
      push @filenames, $1;

    } elsif($_ =~ $untracked_regex) {
      push @untracked, $1;
      push @filenames, $1;

    } else {
      if (@filenames) {
        print to_string($staged, @filenames);
        @filenames = ();
      }
      print $default."$_";
    }
  }


}

sub escape_spaces {
    my ($input_string) = @_;

    # Replace spaces with the escape character
    $input_string =~ s/ /\\ /g;

    return $input_string;
}

sub to_string {
    my ($color, @array) = @_;
    my $text = $color."\t";

    foreach my $filename (@filenames) {
      $text .= escape_spaces($filename)." ";
    }
    $text .= "\n";
    return $text;
}

main();