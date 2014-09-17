package PICA::Writer::Handle;
use strict;

our $VERSION = '0.20';

use Moo::Role;
use Scalar::Util qw(blessed openhandle);
use Carp qw(croak);

has fh => (
    is => 'rw', 
    isa => sub {
        local $Carp::CarpLevel = $Carp::CarpLevel+1;
        croak 'expect filehandle or object with method print!'
            unless defined $_[0] and openhandle($_[0])
            or (blessed $_[0] && $_[0]->can('print'));
    },
    default => sub { \*STDOUT }
);

sub write {
    my $self = shift;
    my $fh   = $self->fh;

    foreach my $record (@_) {
        $record = $record->{record} if ref $record eq 'HASH';
        $self->_write_record($record);
    }
}

1;
__END__

=head1 NAME

PICA::Writer::Handle - Utility class that implements a filehandle attribute to write to

=cut
