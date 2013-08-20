package WWW::MetXML::Role::Agent;
use strict;
use warnings;
use parent 'Exporter';
use Furl;

our $VERSION = "0.01";
our @EXPORT = qw/agent/;

sub agent {
    my $self = shift;
    $self->{agent} ||= Furl->new(agent => join('/', __PACKAGE__, $VERSION));
    return $self->{agent};
}

1;
