#!/usr/bin/env perl

use warnings;
use strict;

use Array::Utils qw(:all);

my $input = 'input.txt';
my @required_features = sort qw(byr iyr eyr hgt hcl ecl pid cid);

sub id_valid {
    my (@id_features) = sort @_;
    my @diff = array_diff(@id_features, @required_features);
    my $difflen = scalar(@diff);

    if ($difflen == 0 || ($difflen == 1 && $diff[0] eq 'cid')) {
        return 1;
    }
    return 0;
}

my $data = do {
    local $/ = undef;
    open my $fh, "<", $input
        or die "Couldn't open input file: $!";
    <$fh>;
};

my @ids = split(/\n\n/, $data);
my $valid = 0;

foreach (@ids) {
    my $id = $_;
    $id =~ s/\s/\|/g;
    my %id_parts = split(/[|:]/, $id);
    if (id_valid(keys %id_parts)) {
        $valid++;
    }
}

print("$valid valid IDs\n");
