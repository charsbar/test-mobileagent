package Test::MobileAgent::Softbank;

use strict;
use warnings;
use base 'Test::MobileAgent::Base';

# this list is borrowed from HTTP::MobileAgent's t/10_softbank.t
sub _list {q(
SoftBank/1.0/910T/TJ001/SNXXXXXXXXX Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1
SoftBank/1.0/910T/TJ001 Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1
)}

1;

__END__

=head1 NAME

Test::MobileAgent::Softbank

=head1 SEE ALSO

See L<HTTP::MobileAgent>'s t/10_softbank.t, from which the data is borrowed.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
