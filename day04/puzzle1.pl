#!/usr/bin/env perl

use warnings;
use strict;

use Array::Utils qw(:all);

my $input = 'input.txt';
my @required_features = sort qw(byr iyr eyr hgt hcl ecl pid cid);
my %id_types = (
    1 => 'valid',
    2 => 'northpole',
    3 => 'invalid'
);

sub id_type {
    my (@id_features) = sort @_;
    my @diff = array_diff(@id_features, @required_features);

    if (scalar(@diff) == 0) {
        return 1;
    } elsif (scalar(@diff) == 1 && $diff[0] eq 'cid') {
        return 2;
    }
    return 3;
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
    if (id_type(keys %id_parts) < 3) {
        $valid++;
    }
}

print("$valid valid IDs\n");
