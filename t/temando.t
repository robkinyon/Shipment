#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 18;

my ($username, $password) = @ARGV;

$username    ||= $ENV{'TEMANDO_USERNAME'} || 'temandotest';
$password ||= $ENV{'TEMANDO_PASSWORD'} || 'password';

use Shipment::Temando;
use Shipment::Address;
use Shipment::Package;


my $from = Shipment::Address->new( 
  company => 'ABC Suppliers',
  name => 'John Doe',
  address1 => '1 Originating Street',
  city => 'Brisbane',
  province => 'QLD',
  country => 'AU',
  postal_code => '4000',
  phone => '(07) 3333 3333',
  email => 'bneoffice@abcsuppliers.com.au',
);

my $to = Shipment::Address->new(
  name => 'Jane Doe',
  address1 => '2 Recipient Street',
  city => 'Sydney',
  province => 'NSW',
  country => 'AU',
  zip => '2000',
  phone => '(02) 9333 3331',
  email => 'jane.doe@yahoo.com.au',
);

my @packages = (
  Shipment::Package->new(
    weight => 10.1,
    length => 18,
    width => 18,
    height => 24,
  ),
  Shipment::Package->new(
    weight => 10.1,
    length => 18,
    width => 18,
    height => 24,
  ),
);

my $shipment = Shipment::Temando->new(
  username => $username,
  password => $password,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ qw( foo bar ) ],
#  live => 1,
);

ok( defined $shipment, 'got a shipment');

ok( defined $shipment->from_address, 'got a shipment->from_address address' );
if (defined $shipment->from_address) {
  is( $shipment->from_address->country_code, 'AU', 'country_code');
}

ok( defined $shipment->to_address, 'got a shipment->to_address address' );
if (defined $shipment->to_address) {
  is( $shipment->to_address->country_code, 'AU', 'country_code');
}

is( $shipment->count_packages, 2, 'shipment has 2 packages');

ok( defined $shipment->services, 'got services');

ok( defined $shipment->services->{ground}, 'got a ground service');
is( $shipment->services->{ground}->id, '54429Road Express', 'ground service_id') if defined $shipment->services->{ground};
ok( defined $shipment->services->{express}, 'got an express service');
is( $shipment->services->{express}->id, '54426Pre-scheduled pick-ups only', 'express service_id') if defined $shipment->services->{express};
ok( defined $shipment->services->{priority}, 'got a priority service');
is( $shipment->services->{priority}->id, '54359Express Premium (eta metro only)', 'priority service_id') if defined $shipment->services->{priority};

$shipment = Shipment::Temando->new(
  username => $username,
  password => $password,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ qw( foo bar ) ],
#  live => 1,
);

$shipment->rate( 'ground' );

ok( defined $shipment->service, 'got a ground rate');
my $rate = $shipment->service->cost->value if defined $shipment->service;
is( $shipment->service->cost->code, 'AUD', 'currency') if defined $shipment->service;

$shipment = Shipment::Temando->new(
  username => $username,
  password => $password,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ qw( foo bar ) ],
#  live => 1,
);

$shipment->ship( 'ground' );

is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;
ok( defined $shipment->labels, 'got labels' );
is( $shipment->labels->content_type, 'application/pdf', 'labels are a pdf') if defined $shipment->get_package(0)->label;

$shipment->labels->save;
$shipment->manifest->save;

$shipment->ship( 'express' );
$shipment->labels->save;
$shipment->manifest->save;

$shipment->ship( 'priority' );
$shipment->labels->save;
$shipment->manifest->save;
=head1 


$shipment->ship( 'ground' );

#is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;
ok( defined $shipment->get_package(0)->label, 'got label' );
is( $shipment->get_package(0)->label->content_type, 'text/ups-epl', 'label is epl') if defined $shipment->get_package(0)->label;

## TODO test saving file to disk
#$shipment->get_package(0)->label->save;

  $shipment = Shipment::UPS->new(
    username => $username,
    password => $password,
    key => $key,
    account => $account,
    tracking_id => '1ZISDE016691676846',
  );

  is( $shipment->cancel, 'Voided', 'successfully cancelled shipment');

@packages = (
  Shipment::Package->new(
    weight => 10,
    length => 18,
    width => 18,
    height => 24,
  ),
  Shipment::Package->new(
    weight => 12,
    length => 20,
    width => 20,
    height => 24,
  ),
);

$shipment = Shipment::UPS->new(
  username => $username,
  password => $password,
  key => $key,
  account => $account,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  residential_address => 1,
  negotiated_rates => 1,
);

is( $shipment->count_packages, 2, 'shipment has 2 packages');

$shipment->rate( 'express' );

ok( defined $shipment->service, 'got an express rate');
$rate = $shipment->service->cost->value if defined $shipment->service;
is( $shipment->service->cost->code, 'USD', 'currency') if defined $shipment->service;

$shipment->ship( 'express' );

#is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;
ok( defined $shipment->get_package(0)->label, 'got first label' );
ok( defined $shipment->get_package(1)->label, 'got second label' );
is( $shipment->get_package(0)->label->content_type, 'text/ups-epl', 'first label is epl') if defined $shipment->get_package(0)->label;
is( $shipment->get_package(1)->label->content_type, 'text/ups-epl', 'second label is epl') if defined $shipment->get_package(1)->label;

## TODO test saving file to disk
#$shipment->get_package(0)->label->save;
#$shipment->get_package(1)->label->save;

  $shipment = Shipment::UPS->new(
    username => $username,
    password => $password,
    key => $key,
    account => $account,
    tracking_id => '1ZISDE016691609089',
    packages => [ 
      Shipment::Package->new(
        tracking_id => '1ZISDE016694068891',
      ),
      Shipment::Package->new(
        tracking_id => '1ZISDE016690889305',
      ),
    ],
  );

  is( $shipment->cancel, 'Voided', 'successfully cancelled shipment');

}
=cut

