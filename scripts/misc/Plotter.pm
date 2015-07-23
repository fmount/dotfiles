#!/bin/perl

package Plotter;

use Chart::Gnuplot;
use Moose;

=begin
Attributi: @values_x e @times_y....non sono required..
Il metodo add_value ce l'ho già e basta wrappare la generate del plot (una sorta di print2.0)
=cut
has 'fname' => ( is => 'rw', isa => 'Str', required => 1 );
has 'values_x' => ( traits => ['Array'], is => 'rw', isa => 'ArrayRef[Int]', default => sub { [] }, handles=>{addValue=>'push' },);
has 'times_y' => ( traits => ['Array'], is => 'rw', isa => 'ArrayRef[Int]', default => sub { [] }, handles=>{addTimestamp=>'push' },);

sub genChart{
  my $self = shift;

  my $chart = Chart::Gnuplot->new(
    output => $self->fname . ".png",
    title  => "Chart Report",
    xlabel => "Temperature",
    ylabel => "Time",
  );

  my $dataSet = Chart::Gnuplot::DataSet->new(
    xdata => ($self->values_x),
    ydata => ($self->times_y),
    title => "Plotting a line from Perl arrays",
    style => "linespoints",
  );

  $chart->plot2d($dataSet);
}


sub timestamp{
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
  my $nice_timestamp = sprintf ( "%02d%02d%02d", $hour,$min,$sec);
  return $nice_timestamp;
}


#This is only for a FAKE TEST!package
package main;
my $plot = Plotter->new(fname=>'FTemp');
$plot->addValue(1);
$plot->addTimestamp($plot->timestamp());
sleep(15);
$plot->addValue(2);
$plot->addTimestamp($plot->timestamp());
sleep(15);
$plot->addValue(3);
$plot->addTimestamp($plot->timestamp());
sleep(15);
$plot->addValue(4);
$plot->addTimestamp($plot->timestamp());

$plot->genChart();


