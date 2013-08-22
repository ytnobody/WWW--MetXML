package WWW::MetXML::Dataset::Data;
use strict;
use warnings;
use parent 'WWW::MetXML::Component::Data';
use WWW::MetXML::Role::Date;

sub data {
    my $self = shift;
    my $rtn = {};
    my @subelements = $self->element('//subelement');
    for my $subelement ( @subelements ) {
        my $key = $subelement->attr('id');
        my @values = $subelement->element('//value');
        $rtn->{$key} = { map {($self->normalize_date($_->attr('date')) => $_->text)} @values };
    }
    return $rtn;
}

1;
