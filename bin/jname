#!/usr/bin/perl
use strict ;
use warnings ;
binmode STDOUT, ":utf8" ;

my ( $netstatcmd ) = `which netstat` ;
$netstatcmd =~ s/\n//g ;
my ( $routecmd ) = "$netstatcmd -nr" ;
my ( $ifconfigcmd ) = `which ifconfig` ;
$ifconfigcmd =~ s/\n//g ;
my ( $ifconfigacmd ) = "$ifconfigcmd -a" ;

sub hex_to_utf {
  my ( $hex ) = @_ ;
  my ( $dec ) = hex( $hex ) ;
  my ( $ori ) = $dec ;
  ##### diff = beyond last letter - first letter
  ##### diff = 91 - 65
  ##### diff = 26
  my ( $diff ) = 26 ;
  while ( $dec < 65 ) {
    $dec += $diff ;
  }
  while ( $dec > 90 ) {
    $dec -= $diff ;
  }
  my ( $utf ) = chr ( $dec ) ;
#  print $hex . ' ' . $ori . ' ' . $dec . ' ' . $utf . "\n";
  $utf;
}

sub defaultnicjname {
  my $name = '' ;
  my $rts = `$routecmd` ;
  my ( $defrt ) = $rts =~ m/default.*/g ;
  if ( $defrt ) {
    my ( $nic ) = $defrt =~ m/\s([[:alnum:]]*)$/g ;
    my $ifa = `$ifconfigcmd $nic` ;
    my ( $ether ) = $ifa =~ m/ether.*/g ;
    my ( $drop, $mac ) =  split( /\s+/, $ether ) ;
    my ( @octets ) = $mac =~ m/\p{HEX}{2}/g ;
    for my $octet ( @octets ) {
      $name .= hex_to_utf( $octet ) ;
    }
  }
  $name ;
}

sub aliasnicjname {
  my $name = '' ;
  my $src = `$ifconfigacmd` ;
  my ( @nics ) = $src =~ m/([[:alnum:]]*)\: flags/g ;
  for my $nic ( @nics ) {
    my $ifa = `$ifconfigcmd $nic` ;
    my ( $ether ) = $ifa =~ m/ether.*/g ;
    if ( $ether ) {
      my ( $drop, $mac ) =  split( /\s+/, $ether ) ;
      my ( @octets ) = $mac =~ m/\p{HEX}{2}/g ;
      for my $octet ( @octets ) {
        $name .= hex_to_utf( $octet ) ;
      }
      $name .= '-' ;
    }
  }
  my ( $defnicjname ) = defaultnicjname() ;
  if ( $defnicjname ) {
    $name =~ s/$defnicjname-//g ;
    $name = $defnicjname . '-' . $name ;
  }
  $name =~ s/-$//g ;
  $name ;
}

#print defaultnicjname() . "\n" ;
print aliasnicjname() . "\n" ;
