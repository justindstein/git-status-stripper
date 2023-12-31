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

my %filetypes_to_arrays = (
    # "UNSET" => []
    "NEW" => []
    , "MODIFIED" => []
    , "DELETED" => []
    , "UNTRACKED" => []
);

my %filetype_labels = (
    "NEW" => "new files:"
    , "MODIFIED" => "modified:"
    , "DELETED" => "deleted:"
    , "UNTRACKED" => "untracked:"
);

my %filetype_color_codes = (
    "NEW" => $staged
    , "MODIFIED" => $unstaged
    , "DELETED" => $unstaged
    , "UNTRACKED" => $unstaged
);

my $current_filetype = "UNSET";

sub main {
  while (<>) {
    if($_ =~ $new_regex) {
      if($current_filetype ne "NEW" && $filetypes_to_arrays{$current_filetype}) {
        # print "$current_filetype";
        if($filetype_labels{$current_filetype}) {
          print $default."\t".$filetype_labels{$current_filetype}
        }

        print array_to_string($filetype_color_codes{$current_filetype}, @{$filetypes_to_arrays{$current_filetype}});

      }
      push @{$filetypes_to_arrays{"NEW"}}, $1;
      $current_filetype = "NEW";

    } elsif($_ =~ $modified_regex) {
      if($current_filetype ne "MODIFIED" && $filetypes_to_arrays{$current_filetype}) {
        if($filetype_labels{$current_filetype}) {
          print $default."\t".$filetype_labels{$current_filetype}
        }

        print array_to_string($filetype_color_codes{$current_filetype}, @{$filetypes_to_arrays{$current_filetype}});
      }
      push @{$filetypes_to_arrays{"MODIFIED"}}, $1;
      $current_filetype = "MODIFIED";

    } elsif($_ =~ $deleted_regex) {
      if($current_filetype ne "DELETED" && $filetypes_to_arrays{$current_filetype}) {
        if($filetype_labels{$current_filetype}) {
          print $default."\t".$filetype_labels{$current_filetype}
        }

        print array_to_string($filetype_color_codes{$current_filetype}, @{$filetypes_to_arrays{$current_filetype}});
      }
      push @{$filetypes_to_arrays{"DELETED"}}, $1;
      $current_filetype = "DELETED";

    } elsif($_ =~ $untracked_regex) {
       if($current_filetype ne "UNTRACKED" && $filetypes_to_arrays{$current_filetype}) {
        if($filetype_labels{$current_filetype}) {
          print $default."\t".$filetype_labels{$current_filetype}
        }

        print array_to_string($filetype_color_codes{$current_filetype}, @{$filetypes_to_arrays{$current_filetype}});
      }
      push @{$filetypes_to_arrays{"UNTRACKED"}}, $1;
      $current_filetype = "UNTRACKED";

    } else {
       if($current_filetype ne "UNSET" && $filetypes_to_arrays{$current_filetype}) {
        if($filetype_labels{$current_filetype}) {
          print $default."\t".$filetype_labels{$current_filetype}
        }
        print array_to_string($filetype_color_codes{$current_filetype}, @{$filetypes_to_arrays{$current_filetype}});
      }
      $current_filetype = "UNSET";

      print $default."$_";
    }
  }
}

sub array_to_string {
    my ($color, @array) = @_;
    my $text = $color."\t";

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

main();