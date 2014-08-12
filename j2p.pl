#!/usr/bin/perl -w

# Note: This perl script is specifically made only for this project.
# Since this script relies on certain conventions, this cannot be used as a
# generic java to pde converter!
#
# Also, to Perl people everywhere, sorry for this mess -- james.

use File::Basename;


print 'cleaning pde/ directory... ';
unlink <pde/*.pde>;
print "done.\n";

my $minfilename = 'HYPE.pde';
my $mintxt;

foreach $file (<java/src/hype/*/*{,/*}.java>) {
	print 'converting `' . basename($file) . '` to pde... ';
	my $outname = 'pde/' . basename($file,'.java') . '.pde';
	
	open (INFILE, $file) or die;
	open (OUTFILE, ">$outname");
	while (<INFILE>) {
		next if ($_ =~ /^\s*(@|import|package)/);
		$_ =~ s/\/\/.*$//;
		$_ =~ s/^public/public static/;
		next if ($_ =~ /^\s*$/);
		
		print OUTFILE $_;
		
		$_ =~ s/\n/ /;
		$mintxt .= $_;
	}
	close (INFILE);
	close (OUTFILE);
	
	print "done.\n";
}

print "writing to $minfilename... ";
open (MINFILE, ">$minfilename");

$mintxt =~ s/\/\*.*?\*\// /g;
$mintxt =~ s/\s+/ /g;
$mintxt =~ s/\s+$//g;
$mintxt =~ s/^\s+//g;
$mintxt .= 'import java.util.*;';
print MINFILE $mintxt;

close (MINFILE);
print "done.\n";