#!/usr/bin/perl -w



die "Usage: $0 <word>\n" if @ARGV != 1;
$word = shift @ARGV;


foreach $file (glob "lyrics/*.txt") {
    open F , "<" ,"$file" or die "file can not open!\n";
    @count=();
	while ($line = <F> ){
		@arr = split /[^a-z]/i , $line;
		foreach $w (@arr){
			$hash{lc $w}++;
		}
		foreach $word (@arr){
		push @count, $word if $word !~ /^$/;
		}
	}
	$all_len=@count;
    if ( exists $hash{lc $word}){
	$word_times=$hash{$word};
    }else{
    $word_times = 0;
    }   
	$var=$word_times / $all_len; 
	$file =~ s/\.txt//;
	$file =~ s/.*\///;
    $file =~ s/_/ /g;
	$result=sprintf( "%4d/%6d = %.9f %s\n",$word_times,$all_len,$var,$file);
	print "$result";
    close F;
    #the way to clean the hash table 
    %hash=();
    @count=();

}





