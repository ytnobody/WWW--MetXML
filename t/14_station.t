use strict;
use warnings;
use Test::More;
use WWW::MetXML::Station;
use Geo::Coordinates::Converter::Point;

my $amedas_tsukuba = WWW::MetXML::Station->new(
    source     => 'amedas', 
    station    => 40336
);
isa_ok $amedas_tsukuba, 'WWW::MetXML::Station';

my $tsukuba = $amedas_tsukuba->item;
isa_ok $tsukuba, 'WWW::MetXML::Station::Data';

is $tsukuba->name, 'Tsukuba';

my $coordinates = $tsukuba->place;
isa_ok $coordinates, 'Geo::Coordinates::Converter::Point';
is_deeply( $coordinates, 
    bless( {
        datum  => 'wgs84',
        format => 'degree',
        height => '25.0',
        lat    => '36.05666732788086',
        lng    => '140.125'
    }, 'Geo::Coordinates::Converter::Point' )
);

my $operational = $tsukuba->operational;
isa_ok $operational->{start}, 'Time::Piece';
is $operational->{end}, undef;
is $operational->{start}->strftime('%Y-%m-%d %H:%M:%S'), '1990-03-01 00:00:00';

done_testing;
