package WWW::MetXML::Role::Data::Name;
use strict;
use warnings;
use parent 'Exporter';

our @EXPORT = qw/name/;

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

1;
