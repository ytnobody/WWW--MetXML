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
    my $sources = $self->{xpath}->find('/sources/source');
    my @rtn;
    while (my $row = $sources->shift) {
        push @rtn, WWW::MetXML::Source::Data->new($row);
    }
    return @rtn;
}

sub source {
    my ($self, $id) = @_;
    my $query = sprintf('/sources/source[@id="%s"]', $id);
    my $row = $self->{xpath}->find($query)->shift;
    return WWW::MetXML::Source::Data->new($row);
}

sub source_ids {
    my $self = shift;
    my @sources = $self->sources;
    return map {$_->id} @sources;
}

sub geo_to_source_ids {
    my ($self, %geo) = @_;
    my $lat = $geo{lat};
    my $lon = $geo{lon};
}

package WWW::MetXML::Source::Data;

sub new {
    my ($class, $source) = @_;
    bless { source => $source }, $class;
}

sub id {
    my $self = shift;
    $self->{source}->getAttribute('id');
}

sub name {
    my $self = shift;
    my $source = $self->{source};
    my $childs = $source->getChildNodes;
    for my $child (@$childs) {
        next unless $child->getName;
        next unless $child->getName eq 'name';
        return $child->string_value;
    }
}

sub geo {
    my $self = shift;
    my $source = $self->{source};
    my $childs = $source->getChildNodes;
    for my $child (@$childs) {
        next unless $child->getName;
        next unless $child->getName eq 'area';
        return +{ map {($_ => $child->getAttribute($_))} qw/nw_lat nw_lon se_lat se_lon/ };
    }
}

1;
