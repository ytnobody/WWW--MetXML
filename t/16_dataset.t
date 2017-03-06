use strict;
use warnings;
use Test::More;
use WWW::MetXML::Dataset;

my $tsukuba = WWW::MetXML::Dataset->new(
    source     => 'amedas', 
    station    => '40336', 
    interval   => ['2013/8/2 10:00', '2013/8/2 14:00'],
    elements   => [qw/ airtemperature rain wind /],
    resolution => 'hourly',
);

isa_ok $tsukuba, 'WWW::MetXML::Dataset';
is $tsukuba->items, 3;
is join(',', $tsukuba->item_ids), 'airtemperature,rain,wind';
my $temp = $tsukuba->item('airtemperature');
isa_ok $temp, 'WWW::MetXML::Dataset::Data';
is_deeply( 
    $temp->data, 
    {
      'ave.' => {
        '2013/08/02 11:00' => '24.6',
        '2013/08/02 12:00' => '25.2',
        '2013/08/02 13:00' => '26.1',
        '2013/08/02 14:00' => '25.5'
      }
    }
);
is_deeply(
    $tsukuba->item('rain')->data,
    {
      'total' => {
        '2013/08/02 11:00' => '0.0',
        '2013/08/02 12:00' => '0.0',
        '2013/08/02 13:00' => '0.0',
        '2013/08/02 14:00' => '0.0'
      }
    }
);

is_deeply(
    $tsukuba->item('wind')->data,
    {
      'direction' => {
        '2013/08/02 11:00' => '68',
        '2013/08/02 12:00' => '90',
        '2013/08/02 13:00' => '68',
        '2013/08/02 14:00' => '112'
      },
      'speed' => {
        '2013/08/02 11:00' => '2',
        '2013/08/02 12:00' => '2',
        '2013/08/02 13:00' => '3',
        '2013/08/02 14:00' => '3'
      }
    }
);

my $kakkumi = WWW::MetXML::Dataset->new(
    source     => 'amedas', 
    station    => '23206', 
    interval   => ['2013/06/30 23:00', '2013/07/04 00:00'],
    elements   => [qw/ airtemperature rain wind /],
    resolution => 'daily',
);

is_deeply(
    $kakkumi->item('airtemperature')->data,
    {
      'ave.' => {
        '2013/07/01' => '14.1',
        '2013/07/02' => '16.0',
        '2013/07/03' => '17.8'
      },
      'max.' => {
        '2013/07/01' => '16.2',
        '2013/07/02' => '18.7',
        '2013/07/03' => '20.8'
      },
      'min.' => {
        '2013/07/01' => '12.0',
        '2013/07/02' => '14.0',
        '2013/07/03' => '15.6'
      }
    }
);

is_deeply(
    $kakkumi->item('rain')->data,
    {
      'total' => {
        '2013/07/01' => '0.0',
        '2013/07/02' => '0.0',
        '2013/07/03' => '1.5'
      }
    }
);

is_deeply(
    $kakkumi->item('wind')->data,
    {
      'speed' => {
        '2013/07/01' => '1',
        '2013/07/02' => '1',
        '2013/07/03' => '1'
      }
    }
);

done_testing;
