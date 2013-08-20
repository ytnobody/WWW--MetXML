package WWW::MetXML::Role::XML;
use strict;
use warnings;
use parent 'Exporter';
use XML::XPath;

our @EXPORT = qw/xml/;

sub xml {
    my ($self, $xml) = @_;
    return XML::XPath->new(xml => $xml);
}

1;
