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

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Role::Agent - HTTP client role

=head1 DESCRIPTION

This is a subclass of Exporter that exports http fetcher feature.

=head1 EXPORTS

=head2 agent

    my $agent = $self->agent;

Returns Furl object.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

