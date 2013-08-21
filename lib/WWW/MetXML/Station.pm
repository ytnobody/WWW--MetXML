package WWW::MetXML::Station;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';
use WWW::MetXML::Role::Items;
use WWW::MetXML::Role::ForceArray;

our $base_url = 'http://pc105.narc.affrc.go.jp/metbroker/stationlist.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    my $xml_url = $self->{base_url} || $base_url;
    $self->{source} = join(',', $self->force_array($self->{source}));
    $self->{elements} = join(':', $self->force_array($self->{elements}));
    $self->{xpath} = $self->fetch_xml($xml_url, %opts);
    return $self;
}

sub items_query { '/stations/source/region/station' }

sub item_query { '/stations/source/region/station[@id="%s"]' }

1;
