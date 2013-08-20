package WWW::MetXML::Region;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';

our $VERSION = 0.01;
our $base_url = 'http://pc105.narc.affrc.go.jp/metbroker/regionlist.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    my $xml_url = $self->{base_url} || $base_url;
    $self->{xpath} = $self->fetch_xml($xml_url, source => $self->{source});
    return $self;
}

sub regions {
    my $self = @_;
    my $regions = $self->{xpath}->find('/regions/source/region');
    my @rtn;
    while (my $region = $regions->shift) {
        push @rtn, $self->data_obejct($region);
    }
    return @rtn;
}

sub region {
    my ($self, $id) = @_;
    my $query = sprintf('/regions/source/region[@id="%s"]', $id);
    my $region = $self->{xpath}->find($query);
    return $self->data_object($region);
}

1;
