package Test::MobileAgent::Jphone;

use strict;
use warnings;
use base 'Test::MobileAgent::Softbank';

# this list is borrowed from HTTP::MobileAgent's t/03_j_phone.t
# last updated: __DATE__
sub _list {q{
__LIST__
}}

1;

__END__

=head1 NAME

Test::MobileAgent::Jphone

=head1 SEE ALSO

See L<HTTP::MobileAgent>'s t/03_j_phone.t, from which the data is borrowed.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
