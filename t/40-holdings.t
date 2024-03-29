use strict;
use warnings;
use Test::More;

use PICA::Data ':all';

my $record = pica_parser('plain', "t/files/bgb.example")->next;
bless $record, 'PICA::Data';

my $items    = $record->items;
is scalar @$items, 353, 'items';
is $items->[0]->{_id}, 851700055, 'epn';

my $holdings = $record->holdings;

is scalar @$holdings, 56, 'holdings';
is $holdings->[0]->{_id}, 252, 'iln';
is $holdings->[-1]->{_id}, 164, 'iln';

is_deeply pica_holdings($holdings->[0]), [ $holdings->[0] ], 'ibid';
is_deeply pica_items($items->[0]), [ $items->[0] ], 'ibid';

is scalar @{ pica_items($holdings->[0]) }, 1, "items (1)";
is scalar @{ pica_items($holdings->[4]) }, 2, "items (2)";
            
done_testing;
