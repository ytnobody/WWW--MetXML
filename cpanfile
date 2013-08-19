requires 'perl', '5.008001';
requires 'Furl';
requires 'XML::XPath';
requires 'Geo::Coordinates::Converter';
requires 'URI';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

