package WWW::MetXML::Role::Data::Name;
use strict;
use warnings;
use parent 'Exporter';

our @EXPORT = qw/name/;

sub name {
    my $self = shift;
    my $source = $self->{source} or return;
    my $childs = $source->getChildNodes;
    for my $child (@$childs) {
        next unless $child->getName;
        next unless $child->getName eq 'name';
        return $child->string_value;
    }
}

1;

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Role::Data::Name - Data name role

=head1 DESCRIPTION

This is a subclass of Exporter that exports data name feature,

=head1 EXPORTS

=head2 name

    my $name = $self->name;

Returns data name as string.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

