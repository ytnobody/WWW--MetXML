package WWW::MetXML::Component::Data;
use strict;
use warnings;
use WWW::MetXML::Role::Coordinates;
use WWW::MetXML::Role::XML;

sub new {
    my ($class, $source) = @_;
    bless { source => $source }, $class;
}

sub attr {
    my ($self, $attr) = @_;
    $self->{source}->getAttribute($attr);
}

sub element {
    my ($self, $query) = @_;
    my $root    = $self->xml($self->to_string);
    my $nodeset = $root->find($query);
    my @rtn;
    while (my $node = $nodeset->shift) {
        push @rtn, __PACKAGE__->new($node);
    }
    return wantarray ? @rtn : $rtn[0];
}

sub text {
    my $self = shift;
    return $self->{source}->string_value;
}

sub value {
    shift->text;
}

sub to_string {
    my $self = shift;
    return $self->{source}->toString;
}

1;
