package WWW::MetXML::Station;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';
use WWW::MetXML::Role::Items;

our $FILENAME = 'station.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    my $xml_url = $self->{base_url} || $self->base_url. $FILENAME;
    $self->{xpath} = $self->fetch_xml($xml_url, %$self);
    return $self;
}

sub items_query { '/station' }

sub item_query { '/station' }

1;
