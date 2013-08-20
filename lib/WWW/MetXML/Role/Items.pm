package WWW::MetXML::Role::Items;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION = "0.01";
our @EXPORT = qw/items item item_ids/;

sub items {
    my $self = shift;
    my $query = $self->items_query;
    my $items = $self->{xpath}->find($query);
    my @rtn;
    while (my $row = $items->shift) {
        push @rtn, $self->data_object($row);
    }
    return @rtn;
}

sub item {
    my ($self, $id) = @_;
    my $query = sprintf($self->item_query, $id);
    my $row = $self->{xpath}->find($query)->shift;
    return $self->data_object($row);
}

sub item_ids {
    my $self = shift;
    my @items = $self->items;
    return map {$_->attr('id')} @items;
}

1;
