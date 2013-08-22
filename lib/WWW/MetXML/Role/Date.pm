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
    return $str =~ m|^[0-9]{4}/[0-9]{2}/[0-9]{2}$| ? Time::Piece->strptime($str, '%Y/%m/%d') : Time::Piece->strptime('%Y/%m/%d %H:%M');
}

1;
