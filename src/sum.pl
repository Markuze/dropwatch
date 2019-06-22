#!/usr/bin/perl -w

use strict;
use autodie;
use List::BinarySearch qw( binsearch  binsearch_pos  binsearch_range );
use bigint qw(hex);

my $kallsyms_file = './kallsyms';
my %addr = ();
my @kallsyms = ();

sub by_addr {
	my $a = shift;
	my $b = shift;

	$b =~ /^([0-9a-f]+)/;
	my $b_num = $1;
	#printf "[$a] <=> [$b]($b_num)\n";

	return hex($a) <=> hex($b_num);
}

sub prep_kalsyms {
	open my $fh, '<', "$kallsyms_file";
	foreach (<$fh>) {
		chomp;
		push @kallsyms, $_;
	}
	close $fh
}

prep_kalsyms;

while (<>) {
	chomp;
	next unless /^(\d+)\D+(0x[a-f0-9]+)$/;
	$addr{$2} += $1;
}


my $sort = \&by_addr;

for (sort {$addr{$a} <=> $addr{$b}} keys(%addr)) {
	my $idx = 0;
	$idx = binsearch_pos { by_addr $a, $b } $_, @kallsyms;
	#$idx = binsearch_pos { $a cmp $b } $addr{$_}, @kallsyms;
	$kallsyms[$idx -1] =~ /^([0-9a-f]+)/;
	my $addr = $1;
	$addr = hex($_) - hex("0x$addr");
	printf "$_: $addr{$_}: $kallsyms[$idx -1] (0x%x)\n", $addr;
}
