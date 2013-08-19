use strict;
use warnings;
use Test::More;
use WWW::MetXML::Source;

my $wms = WWW::MetXML::Source->new;
isa_ok $wms, 'WWW::MetXML::Source';
can_ok $wms, qw/sources source source_ids/;
is $wms->sources, 17;

my $amedas = $wms->source('amedas');
isa_ok $amedas, 'WWW::MetXML::Source::Data';
is join(',', $wms->source_ids), 'aclima,amedas,fieldserver,hitsujigaoka,kanagawa,mamedas,noaa,prefmetdb,snuwdms,wakayama,ThaiFs,sasa,GD-DR&TR,WRDC,fawn,gaemn,oregonIPPC';

is $amedas->name, 'AmeDAS(Japan)';
is_deeply($amedas->geo, +{nw_lat => "46.0", nw_lon => "122.0", se_lat => "20.0", se_lon => "146.0"});

done_testing;
