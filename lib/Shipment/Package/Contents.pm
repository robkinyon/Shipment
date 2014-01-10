package Shipment::Package::Contents;
use strict;
use warnings;

=head1 NAME

Shipment::Package::Contents - an item within a package

=head1 SYNOPSIS

  use Shipment::Package;

  my $package = Shipment::Package->new(
    weight => 10,
    length => 18,
    width  => 18,
    height => 24,
  );

  $package->add_contents({
    name => 'Thing 1',
    number_of_pieces => 4,
    country_of_manufacture => 'US', # Defaults to from_address->country_code
    weight => 4, # Defaults to $package->weight
  });

=head1 ABOUT

This class defines the contents of a package to be shipped. This is normally
optional. If you are shipping across borders, you B<must> specify the contents
in order to construct the customs information.

=cut

use Data::Currency;

use Moose 2.0000;

=head1 Class Attributes

=head2 name

The name of the commodity

type: String

=cut

has 'name' => (
  is => 'rw',
  isa => 'Str',
);

=head2 number_of_pieces

The number of pieces in this commodity.

type: Number

=cut

has 'number_of_pieces' => (
  is => 'rw',
  isa => 'Num',
);

=head2 description

A description of the item.

type: String

=cut

has 'description' => (
  is => 'rw',
  isa => 'Str',
);

=head2 country_of_manufacture

What country was this made?

type: String

=cut

has 'country_of_manufacture' => (
  is => 'rw',
  isa => 'Str',
);

=head2 harmonized_code

The Harmonized Code for this item (from the FedEx Global Trade Manager).

type: String

=cut

has 'harmonized_code' => (
  is => 'rw',
  isa => 'Str',
);

=head2 weight

The weight of this item.

type: Number

=cut

has 'weight' => (
  is => 'rw',
  isa => 'Num',
);

=head2 quantity, quantity_units

The quantity of this item and unit of measure to express the quantity.

type: Number, String

=cut

has 'quantity' => (
  is => 'rw',
  isa => 'Num',
);

has 'quantity_units' => (
  is => 'rw',
  isa => 'Str',
);

=head2 additional_measures

Any additional quantitative information (other than weight and quantity) to
calculate duties and taxes.

type: String

=cut

has 'additional_measures' => (
  is => 'rw',
  isa => 'String',
);

=head2 unit_price

Value of each unit in Quantity. Six explicit decimal positions, Max length of 18
(including the decimal point).

type: String

=cut

has 'unit_price' => (
  is => 'rw',
  isa => 'Str',
);

=head2 customs_value

The customs value for this item.

type: String

=cut

has 'customs_value' => (
  is => 'rw',
  isa => 'Str',
);

=head2 excise_conditions

Additional characteristics of this item used to calculate duties 

type: String

=cut

has 'excise_conditions' => (
  is => 'rw',
  isa => 'Str',
);

=head2 export_license_number

Applicable to US export shipping only.

type: String

=cut

has 'export_license_number' => (
  is => 'rw',
  isa => 'Str',
);

=head2 export_license_expiration_date

Only applicable if export_license_number is set. Must be at least 1 day in the
future.

type: String

=cut

has 'export_license_expiration_date' => (
  is => 'rw',
  isa => 'Str',
);

=head2 ci_marks_and_numbers

An identifying mark or number used on the packaging of the shipment.

type: String

=cut

has 'ci_marks_and_numbers' => (
  is => 'rw',
  isa => 'Str',
);

no Moose;

=head1 AUTHOR

Andrew Baerg @ <andrew at pullingshots dot ca>

http://pullingshots.ca/

=head1 BUGS

Please contact me directly.

=head1 COPYRIGHT

Copyright (C) 2010 Andrew J Baerg, All Rights Reserved

=head1 NO WARRANTY

Absolutely, positively NO WARRANTY, neither express or implied, is
offered with this software.  You use this software at your own risk.  In
case of loss, no person or entity owes you anything whatsoever.  You
have been warned.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
