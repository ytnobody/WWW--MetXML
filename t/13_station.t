use strict;
use warnings;
use Test::More;
use WWW::MetXML::Station;
use Geo::Coordinates::Converter::Point;

my $amedas_hokkaido = WWW::MetXML::Station->new(
    source     => 'amedas:01', 
    elements   => [qw/airtemperature rain/],
    resolugion => 'daily',
);

isa_ok $amedas_hokkaido, 'WWW::MetXML::Station';
is $amedas_hokkaido->items, 203;
is join(',', $amedas_hokkaido->item_ids), '11001,11011,11012,11016,11046,11061,11076,11091,11121,11151,11176,11206,11276,11291,11316,12011,12041,12141,12181,12231,12261,12266,12301,12386,12396,12411,12441,12442,12451,12501,12511,12512,12551,12596,12626,12632,12691,12746,13061,13086,13121,13146,13181,13261,13276,13277,13311,13321,14026,14071,14086,14101,14116,14121,14136,14161,14162,14163,14171,14206,14286,14296,15041,15076,15116,15161,15231,15241,15251,15311,15321,15356,15431,15442,16026,16061,16076,16091,16156,16206,16216,16217,16251,16252,16281,16286,16321,17036,17076,17091,17111,17112,17116,17166,17196,17246,17306,17316,17341,17351,17481,17482,17501,17521,17531,17546,17561,17596,17607,17631,17716,17717,18036,18037,18038,18136,18161,18171,18174,18206,18256,18271,18272,18273,18281,18311,19021,19051,19076,19151,19191,19261,19311,19347,19376,19416,19431,19432,19451,20146,20186,20266,20276,20341,20356,20361,20371,20421,20431,20432,20441,20506,20551,20556,20601,20606,20631,20696,20751,21111,21126,21161,21171,21186,21187,21226,21261,21276,21296,21297,21312,21321,21322,21323,22036,22141,22156,22241,22291,22306,22326,22327,22391,23031,23086,23126,23166,23206,23226,23231,23232,23281,23326,23376,24041,24051,24101,24131,24141,24156,24201,24216,24217';

my $urahoro = $amedas_hokkaido->item('20506');
isa_ok $urahoro, 'WWW::MetXML::Station::Data';
is $urahoro->name, 'Urahoro';

my $operational = $urahoro->element('//operational');
isa_ok $operational, 'WWW::MetXML::Component::Data';
is $operational->attr('start'), '1976/04/01 0:00:00';

my @elements = $urahoro->element('//element');
is join(',', map{$_->attr('id')} @elements), 'air temperature,rain,wind,bright sunlight';

my $coordinates = $urahoro->place;
isa_ok $coordinates, 'Geo::Coordinates::Converter::Point';
is_deeply( $coordinates, 
    bless( {
        datum  => 'wgs84',
        format => 'degree',
        height => '20.0',
        lat    => '42.80833435058594',
        lng    => '143.6566619873047'
    }, 'Geo::Coordinates::Converter::Point' )
);

done_testing;
