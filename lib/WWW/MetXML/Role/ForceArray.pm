package WWW::MetXML::Role::ForceArray;
use strict;
use warnings;
use parent 'Exporter';

our @EXPORT = qw/force_array/;

sub force_array {
    my ($self, $var) = @_;
    ref($var) eq 'ARRAY' ? @$var : $var;
}

1;
