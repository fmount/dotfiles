#!/bin/perl

package main;

=begin comment
Author: frances-co
v.0.1.alpha
=cut


=begin
TODO: collect values using the Plotter module ...
=cut

use strict;
use warnings;
use Switch;
#use Plotter;

my %conf = ();
#our $DBG = -1;
our $DBG = 0;

our $round = 9;  #Critical_max - critical_min => 9 is the default value..


#Adding i8kctl support
sub i8k{
  my $i8 = `i8kctl`;
  return split(/ /,$i8);
}


sub init{
  my $file = shift;
  open(my $handler, $file) || die "Can't open '$file': $!";
  while(my $r = <$handler>){
    #print("Conf line: " . $r);
    my @tokens = split(/:/, $r);
	$conf{$tokens[0]} = $tokens[1];
  }
  close($handler);

  $round = $conf{'critical_temp_max'} - $conf{'critical_temp_min'};
}

sub get_temps(){
  opendir(DIR, $conf{'bus_path'}) || die "Can't find the dir";
  my @temps=[];
  my $tmp_file;
  while($tmp_file = readdir(DIR)){
  	if($tmp_file =~ $conf{'fname'}){
  	  push @temps, $tmp_file;
      }
  }
  closedir(DIR);
  for(my $i=0;$i<scalar(@temps); $i++){
	if($temps[$i] =~ $conf{'fname'}){
      my $fname = $conf{'bus_path'} . $temps[$i];
      open(my $fh,$fname) || die "Can't open '$fname': $!";
      my $temp1 = <$fh>;
      $temps[$i] = $temp1;
      close($fh);
    }
  }
  return @temps;
}

sub avg{
  my $sum = 0;
  my @tmp = @_;
  for(my $i=1; $i<scalar(@tmp); $i++){
    $sum+=@tmp[$i];
  }
  print("Average: ". (($sum/1000)/(scalar(@tmp)-1)) . "\n");
  return (($sum/1000)/(scalar(@tmp)-1));
}


sub i8kact{
	my($temp, $speed) = @_;
	print($temp . " - " . $speed . "\n");
	switch($speed){
	  case 0{
	    if($temp >= $conf{'critical_temp_max'}){
		  print("Turn on");
		  system("i8kfan", "-1", "2");
		}
	  }
	  case 2800{
		if($temp >= $conf{'critical_temp_max'}){
		  print("Turn on");
		  system("i8kfan", "-1", "2");
		}
	  }
	  else{
	    if($temp < ($conf{'critical_temp_max'}-$round)){
		  print("Turn off");
		  system("i8kfan", "-1", "0");
		}
		elsif($temp >= $conf{'critical_temp_max'}){
		  print("Turn on");
		  system("i8kfan", "-1", "2");
		}
		else{
			print("Medium is ok");
		    system("i8kfan", "-1", "1");
		}
	  }
	}
}

sub main{

  while($DBG == 0){	
    #Refreshing parameters..
    my @i8params = i8k();


    my $temp = $i8params[3];
    my $fspeed = $i8params[7];
    i8kact($temp, $fspeed);

    sleep($conf{'check_time'});
  }
}

init("mon.conf");
main();
