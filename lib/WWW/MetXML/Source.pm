package WWW::MetXML::Source;
use strict;
use warnings;
use XML::XPath;
use Furl;
use Carp;

our $VERSION = "0.01";
our $base_url = 'http://pc105.narc.affrc.go.jp/metbroker/sourcelist.xml';

sub new {
    my ($class, %opts) = @_;
    my $xml = $class->_fetch_xml($opts{base_url} || $base_url);
    my $xpath = XML::XPath->new(xml => $xml);
    bless {%opts, xpath => $xpath}, $class;
}

sub _fetch_xml {
    my ($class, $url) = @_;
    local $Carp::CarpLevel = $Carp::CarpLevel + 1;
    my $agent = Furl->new(agent => join('/', $class, $VERSION));
    my $res = $agent->get($url);
    croak($res->status_line) unless $res->is_success;
    return $res->content;
}

sub sources {
    my $self = shift;
    return $self->{xpath}->find('/sources/source');
}

sub source {
    my ($self, $id) = @_;
    my $query = sprintf('/sources/source[@id="%s"]', $id);
    return $self->{xpath}->find($query)->shift;
}

sub source_ids {
    my $self = shift;
    my $sources = $self->sources;
    my @rtn;
    while ( my $source = $sources->shift ) {
        push @rtn, $source->getAttribute('id');
    }
    return @rtn;
}

sub id_to_name {
    my ($self, $id) = @_;
    my $source = $self->source($id);
    my $childs = $source->getChildNodes;
    for my $child (@$childs) {
        next unless $child->getName;
        next unless $child->getName eq 'name';
        return $child->string_value;
    }
}

sub id_to_geo {
    my ($self, $id) = @_;
    my $source = $self->source($id);
    my $childs = $source->getChildNodes;
    for my $child (@$childs) {
        next unless $child->getName;
        next unless $child->getName eq 'area';
        return +{ map {($_ => $child->getAttribute($_))} qw/nw_lat nw_lon se_lat se_lon/ };
    }
}

1;
