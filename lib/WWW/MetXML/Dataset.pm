package WWW::MetXML::Dataset;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';
use WWW::MetXML::Role::Items;

our $base_url = 'http://pc105.narc.affrc.go.jp/metbroker/dataset.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    $self->{interval} = join('-', $self->force_array($self->{interval})) if $self->{interval};
    $self->{elements} = join(':', $self->force_array($self->{elements})) if $self->{elements};
    my $xml_url = $self->{base_url} || $base_url;
    $self->{xpath} = $self->fetch_xml($xml_url, %$self);
    return $self;
}

sub items_query { '//element' }

sub item_query { '//element[@id="%s"]' }

1;
