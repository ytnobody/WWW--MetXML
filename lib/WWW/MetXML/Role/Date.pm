package WWW::MetXML::Role::Date;
use strict;
use warnings;
use parent 'Exporter';
use Time::Piece ();

our @EXPORT = qw/ normalize_date time_piece /;

sub normalize_date {
    my ($self, $str) = @_;
    $str =~ s{/([0-9])/}{/0$1/};
    $str =~ s{/([0-9])\s}{/0$1 };
    $str =~ s{/([0-9])$}{/0$1};
    $str =~ s{\s([0-9]):}{ 0$1:};
    return $str;
}

sub time_piece {
    my ($self, $str) = @_;
    $str = $self->normalize_date($str);
    return 
        $str =~ m|^[0-9]{4}/[0-9]{2}/[0-9]{2}$| ? Time::Piece->strptime($str, '%Y/%m/%d') : 
        $str =~ m|^[0-9]{4}/[0-9]{2}/[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$| ? Time::Piece->strptime($str, '%Y/%m/%d %H:%M:%S') : 
        Time::Piece->strptime('%Y/%m/%d %H:%M')
    ;
}

1;

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Role::Date - Date role

=head1 DESCRIPTION

This is a subclass of Exporter that exports date feature

=head1 EXPORTS

=head2 time_piece

    my $time = $self->time_piece('2012/3/2 9:40');

Returns Time::Piece object that wraps specified time string.

=head2 normalize_date

    my $normalized = $self->normalized_date('2012/3/2 9:40'); # '2012/03/02 09:40';

Returns normalized datetime string.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

