#!/bin/perl

=begin comment
Author: frances-co
v.0.1.alpha
=cut


=begin
TODO: READ AND CHECK FANs STATE / SMART START AND STOP
=cut

use strict;
use warnings;
use Switch;

my $path = "/sys/bus/platform/devices/coretemp.0/hwmon/hwmon1/";
my $regex = "temp[0123456789]_input";
my $critical_max = 62;
my $checkTime = 120;

my $fanLock = -1; # -1 = fan turned off - 0 = fan turned on..
my %conf = ();

our $name = substr $0, 2;

sub init{
  my $file = shift;
  open(my $handler, $file) || die "Can't open '$file': $!";
  while(my $r = <$handler>){
    #print("Conf line: " . $r);
    my @tokens = split(/:/, $r);
	$conf{$tokens[0]} = $tokens[1];
  }
  close($handler);
  print(%conf);
}

sub get_temps(){
  opendir(DIR, $path) || die "Can't find the dir";
  my @temps=[];
  my $tmp_file;
  while($tmp_file = readdir(DIR)){
  	if($tmp_file =~ $regex){
  	  push @temps, $tmp_file;
      }
  }
  closedir(DIR);
  for(my $i=0;$i<scalar(@temps); $i++){
	if($temps[$i] =~ $regex){
      my $fname = $path . $temps[$i];
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



sub main{

  my $pid = `pgrep mon.pl`;
  print("The PGREP of the script " . $name . " returns: " . $pid);

  while(1){
    my @te = get_temps();
    print(@te);
    my $avg_temp = avg(@te);


=begin comment
    switch($fanLock){
    case -1{
	  print "Fan off\n";
    }
    case 0{
      print "Fan on\n";
	}
    else{
      print "previous case not true"
	}
  }
=cut

    print("FAN: " . $fanLock . "\n");
    if($avg_temp >= $critical_max && $fanLock != 0){
	    print("Turn ON the FanS\n");
	    $fanLock = 0;
	    system("i8kfan", "-1", "2");
    }
    elsif($avg_temp <= $critical_max && $fanLock == 0){
	    print("Turn OFF the FanS\n");
	    $fanLock = -1;
	    system("i8kfan", "-1", "1");
    }
    else{
	  print("Do nothing!\n");
    }
    sleep($checkTime);
  }
}

init("mon.conf");
main();
