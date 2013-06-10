#!/usr/bin/perl
use strict ;
use warnings ;
binmode STDOUT, ":utf8" ;

my ( $netstatcmd ) = `which netstat` ;
$netstatcmd =~ s/\n//g ;
my ( $iocmd ) = "$netstatcmd -n -i -b|egrep -v '(:|lo0)'" ;
my ( $ifconfigcmd ) = `which ifconfig` ;
$ifconfigcmd =~ s/\n//g ;
my ( $ifconfigacmd ) = "$ifconfigcmd -a|egrep -v 'lo0'" ;
my @globalold ;
my ( $os ) = `uname -s` ;
my ( $freebsd ) = $os =~ m/FreeBSD/g ;

sub getdata {
  my ( $nic ) = @_ ;
  my ( @data ) ;
  my $in ;
  my $out ;
  if ( $freebsd ) {
    $in = `$iocmd|grep $nic|awk '{printf "%.1f", \$8}'` ;
    $out = `$iocmd|grep $nic|awk '{printf "%.1f", \$11}'` ;
  }
  else {
    $in = `$iocmd|grep $nic|awk '{printf "%.1f", \$7}'` ;
    $out = `$iocmd|grep $nic|awk '{printf "%.1f", \$10}'` ;
  }
  if ( $in ) {
    if ( $in > 0 ) {
      $data[ 0 ] = $in ;
    }
  }
  if ( $out ) {
    if ( $out > 0 ) {
      $data[ 1 ] = $out ;
    }
  }
  if ( $data[ 0 ] ) {
    @data ;
  }
}

sub diffdata {
  my ( $nic ) = @_ ;
  my ( @data ) ;
  if ( $globalold[ 0 ] ) {
    my @new = getdata( $nic ) ;
    if ( $new[ 0 ] ) {
      $data[ 0 ] = $new[ 0 ] - $globalold[ 0 ] ;
      $data[ 1 ] = $new[ 1 ] - $globalold[ 1 ] ;
      @globalold = @new ;
    }
  }
  else {
    @globalold = getdata( $nic ) ;
  }
  if ( $data[ 0 ] ) {
    @data ;
  }
}

sub allspeed {
  my $in = '' ;
  my $out = '' ;
  my $ifs = `$ifconfigacmd` ;
  my ( @nics ) = $ifs =~ m/([[:alnum:]]*)\: flags/g ;
  for my $nic ( @nics ) {
    my @data = diffdata( $nic ) ;
    if ( $data[ 0 ] ) {
      printf  "%s %.3f %.3f M/s\n", $nic , ( $data[ 0 ] / 5 / 1024 / 1024 ) , ( $data[ 1 ] / 5 / 1024 / 1024 ) ;
    }
  }
}

for (;;sleep 5) {
  allspeed() ;
}
