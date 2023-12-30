#!/usr/bin/perl -w 
use strict;
use warnings;

# ANSI escape codes for text color
my $green = "\e[92m";
my $red = "\e[31m";
# my $white = "\e[37m";

my $added = $green;
my $modified = $red;
my $default = "\e[0m";
 
# while (<> ) {
#   print "foo: $_";
# }

while (<>) {
  # print "foo: $_";

  if($_ =~ /^\t(?:new\ file:\s*)(.*)$/g) {
  
    # while ($_ =~ /^\t(?:deleted:\s*|modified:\s*|)(.*)$/g) {
    my $foo = $1;
    $foo =~ s/ /\\ /g; 
    print $added."    $foo\n";

  } elsif($_ =~ /^\t(?:deleted:\s*|modified:\s*|)(.*)$/g) {
    my $foo = $1;
    $foo =~ s/ /\\ /g; 
    print $modified."    $foo\n";

  } else {
    print $default.$_;
  }

# foreach my $line ( <STDIN> ) {
#   chomp( $line );
  # print "$line\n";

  # while ($line =~ /^\t(?:deleted:\s*|modified:\s*|)(.*)$/g) {
  #   print "$1\n";
  # }

#   (?mx)↵
# ^\t # Left padding↵
# (?:deleted:\s*|modified:\s*|) # 'deleted:' or 'modified:' tags↵
# (.*) # Capture all remaining text↵
# $
# }
}