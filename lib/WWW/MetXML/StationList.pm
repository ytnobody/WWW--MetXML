package WWW::MetXML::StationList;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';
use WWW::MetXML::Role::Items;

our $FILENAME = 'stationlist.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    my $xml_url = $self->{base_url} || $self->base_url. $FILENAME;
    $self->{source} = join(',', $self->force_array($self->{source})) if $self->{source};
    $self->{elements} = join(':', $self->force_array($self->{elements})) if $self->{elements};
    if ($self->{area}) {
        $self->{area} = ref($self->{area}) eq 'HASH' ? $self->_geo_area($self->{area}) : $self->{area};
    }
    $self->{xpath} = $self->fetch_xml($xml_url, %$self);
    return $self;
}

sub _geo_area {
    my ($self, $hashref) = @_;
    return join(',', $hashref->{nw}{lat}, $hashref->{nw}{lng}, $hashref->{se}{lat}, $hashref->{se}{lng});
}

sub items_query { '//station' }

sub item_query { '//station[@id="%s"]' }

1;
