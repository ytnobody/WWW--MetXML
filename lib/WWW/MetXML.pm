package WWW::MetXML;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";



1;
__END__

=encoding utf-8

=head1 NAME

WWW::MetXML - Perl Interface of MetXML(MetBroker XML)

=head1 SYNOPSIS

    use WWW::MetXML;
    my $metxml = WWW::MetXML->new;
    my $res = $metxml->get(
        lang       => 'ja',
        source     => 'amedas', 
        station    => '40336', 
        begin      => '2013-08-19', 
        end        => '2013-08-20', 
        resolution => 'hourly',
        elements   => [qw/airtemperature rain wind/],
    );
    my $temp = $res->element('airtemperature');
    my $max_temp = $res->subelement('Max');
    say $max_temp->value('2013-08-19 13:00'); # 33.6 (unit = Celsius temp.)
    my $wind = $res->element('wind');
    my $wind_speed = $res->subelement('Speed');
    say $wind_speed->value('2013-08-19 13:00'); # 3 (unit = m/s)

=head1 DESCRIPTION

MetXML(MetBroker XML) is an open API for accessing stored weather data, by National Agriculture and Food Research Organization, of Japan.

WWW::MetXML provides object oriented interface for MetXML.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

L<http://pc105.narc.affrc.go.jp/metbroker/xml/>

=cut

