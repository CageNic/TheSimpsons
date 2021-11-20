#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

my $file = '/home/alice/R/simpsons_data.csv';

# build the regex in a subroutine
sub text_parser {
	my ($text) = @_;
# no g modifier on the qr creation
	my $regex = qr/homer/i;
	if ($text =~ m/$regex/g) {
		return say $text;
	}
}

open (my $fh,'<',$file);
while (my $lines = <$fh>) {
  chomp $lines;
  text_parser($lines);
  }
close $fh;
exit;
