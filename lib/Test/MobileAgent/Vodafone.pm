package Test::MobileAgent::Vodafone;

use strict;
use warnings;
use base 'Test::MobileAgent::Base';

# this list is borrowed from HTTP::MobileAgent's t/09_vodafone_3gc.t
sub _list {q(
Nokia6820/2.0 (4.83) Profile/MIDP-1.0 Configuration/CLDC-1.0 (compatible; Googlebot-Mobile/2.1; +http://www.google.com/bot.html)
Vodafone/1.0/V702NK/NKJ001 Series60/2.6 Profile/MIDP-2.0 Configuration/CLDC-1.1
Vodafone/1.0/V802SE/SEJ001/SNXXXXXXXXX Browser/SEMC-Browser/4.1 Profile/MIDP-2.0 Configuration/CLDC-1.10
Vodafone/1.0/V902SH/SHJ001/SN999999999999999 Browser/UP.Browser/7.0.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1 Ext-J-Profile/JSCL-1.2.2 Ext-V-Profile/VSCL-2.0.0
MOT-V980/80.2B.04I MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1
MOT-V980/80.2F.2E. MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1
)}

1;

__END__

=head1 NAME

Test::MobileAgent::Vodafone

=head1 SEE ALSO

See L<HTTP::MobileAgent>'s t/09_vodafone_3gc.t, from which the data is borrowed.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
