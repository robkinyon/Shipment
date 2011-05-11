
package Shipment::Purolator::WSDL::Elements::ServiceOptionRules;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://purolator.com/pws/datatypes/v1' }

__PACKAGE__->__set_name('ServiceOptionRules');
__PACKAGE__->__set_nillable(1);
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();
use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    Shipment::Purolator::WSDL::Types::ServiceOptionRules
);

}

1;


=pod

=head1 NAME

Shipment::Purolator::WSDL::Elements::ServiceOptionRules

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
ServiceOptionRules from the namespace http://purolator.com/pws/datatypes/v1.







=head1 METHODS

=head2 new

 my $element = Shipment::Purolator::WSDL::Elements::ServiceOptionRules->new($data);

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDL::Types::ServiceOptionRules
   ServiceID =>  $some_value, # string
   Exclusions =>  { # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
     OptionIDValuePair =>  { # Shipment::Purolator::WSDL::Types::OptionIDValuePair
       ID =>  $some_value, # string
       Value =>  $some_value, # string
     },
   },
   Inclusions => {}, # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut
