package WWW::MetXML::Region;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';
use WWW::MetXML::Role::Items;
use WWW::MetXML::Role::ItemsByGeo;
use WWW::MetXML::Role::ForceArray;

our $VERSION = 0.01;
our $base_url = 'http://pc105.narc.affrc.go.jp/metbroker/regionlist.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    my $xml_url = $self->{base_url} || $base_url;
    $self->{xpath} = $self->fetch_xml($xml_url, source => join(',', $self->force_array($self->{source})));
    return $self;
}

sub items_query { '/regions/source/region' }

sub item_query { '/regions/source/region[@id="%s"]' }

1;
