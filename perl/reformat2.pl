#!usr/bin/perl

@array = ();

# ansをidごとに1行にする。
while(<>){
	chomp;
	$line = $_;
	$line =~ s/,],/],/g;
	$line =~ s/],/],\n/g;
	@array = split(/\n/, $line)

}

#---------------------------------------#
# 出力
#---------------------------------------#

foreach(@array){
	print "$_\n";
}


