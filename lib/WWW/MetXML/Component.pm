package WWW::MetXML::Component;
use strict;
use warnings;
use WWW::MetXML::Role::Agent;
use WWW::MetXML::Role::Coordinates;
use WWW::MetXML::Role::XML;
use WWW::MetXML::Role::ForceArray;
use Module::Load ();
use URI;
use Carp;

sub new {
    my ($class, %opts) = @_;
    bless {%opts}, $class;
}

sub lang {
    my $self = shift;
    return $self->{lang} || 'en';
}

sub fetch_xml {
    my ($self, $url, %params) = @_;
    my $uri = URI->new($url);
    $uri->query_form(%params, lang => $self->lang);
    my $res = $self->agent->get($uri->as_string);
    croak($res->status_line) unless $res->is_success;
    return $self->xml($res->content);
}

sub data_object {
    my ($self, $xml) = @_;
    my $class = $self->data_class;
    return $class->new($xml);
}

sub data_class {
    my $self = shift;
    my $class = ref($self);
    my $data_class = $class.'::Data';
    Module::Load::load($data_class) unless $data_class->can('new');
    return $data_class;
}

1;
