#!/usr/bin/env perl

use warnings;
use strict;

use Array::Utils qw(:all);
use Scalar::Util qw(looks_like_number);

use Data::Dumper;

my $input = 'input.txt';
my @required_features = sort qw(byr iyr eyr hgt hcl ecl pid cid);
my @eyecolors  = qw(amb blu brn gry grn hzl oth);

my %validations = (
    'byr' => sub {
        return valid_year(@_, 1920, 2002);
    },
    'iyr' => sub {
        return valid_year(@_, 2010, 2020);
    },
    'eyr' => sub {
        return valid_year(@_, 2020, 2030);
    },
    'hgt' => sub {
        my ($val) = @_;
        if ($val =~ /(?<!\d)(\d{2}|\d{3})(?!\d)(in|cm)/i) {
            if (($2 eq 'cm' && $1 >= 150 && $1 <= 193) ||
                ($2 eq 'in' && $1 >= 59 && $1 <= 76)) {
                return 1;
            }
        }
        return 0;
    },
    'hcl' => sub {
        my ($val) = @_;
        if ($val =~ /^#[0-9a-f]{6}/i) {
            return 1;
        }
        return 0;
    },
    'ecl' => sub {
        my ($val) = @_;
        if (lc $val ~~ @eyecolors) {
            return 1;
        }
        return 0;
    },
    'pid' => sub {
        my ($val) = @_;
        if ($val =~ /^\d{9}$/) {
            return 1;
        }
        return 0;
    },
    'cid' => sub {
        return 1;
    }

);

sub valid_year {
    my ($val, $min, $max) = @_;
    if (!looks_like_number($val)) {
        return 0;
    } elsif ($val >= $min && $val <= $max) {
        return 1;
    }
    return 0;
}

sub valid_featureset {
    my (@id_features) = sort @_;
    my @diff = array_diff(@id_features, @required_features);
    my $difflen = scalar(@diff);

    if ($difflen == 0 || ($difflen == 1 && $diff[0] eq 'cid')) {
        return 1;
    }
    return 0;
}

sub valid_data {
    my (%id_data) = @_;
    while (my ($key, $value) = each (%id_data)) {
        if (!$validations{$key}->($value)) {
            return 0;
        }
    }
    return 1;
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
    if (valid_featureset(keys %id_parts)) {
        if (valid_data(%id_parts)) {
            $valid++;
        }
    }
}

print("$valid valid IDs\n");
