package WWW::MetXML::Component::Data;
use strict;
use warnings;
use WWW::MetXML::Role::Coordinates;

sub new {
    my ($class, $source) = @_;
    bless { source => $source }, $class;
}

sub attr {
    my ($self, $attr) = @_;
    $self->{source}->getAttribute($attr);
}

1;
