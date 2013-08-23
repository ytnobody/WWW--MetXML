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

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Role::ForceArray - Array transformer role

=head1 DESCRIPTION

This is a subclass of Exporter that exports array transform feature

=head1 EXPORTS

=head2 force_array

    my @res1 = $self->force_array( [ 2, 3, 4] ); # @res1 = ( 2, 3, 4 );
    my @res2 = $self->force_array( 3 );          # @res2 = ( 3 );

Transform specified (arrayref|scalar) as array in united rule.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

