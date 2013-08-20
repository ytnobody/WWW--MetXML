package WWW::MetXML::Component;
use strict;
use warnings;
use WWW::MetXML::Role::Agent;
use WWW::MetXML::Role::Coordinates;
use WWW::MetXML::Role::XML;
use URI;
use Carp;

sub new {
    my ($class, %opts) = @_;
    bless {%opts}, $class;
}

sub fetch_xml {
    my ($self, $url, %params) = @_;
    my $uri = URI->new($url);
    $uri->query_form(%params);
    my $res = $self->agent->get($uri->as_string);
    croak($res->status_line) unless $res->is_success;
    return $self->xml($res->content);
}

1;
