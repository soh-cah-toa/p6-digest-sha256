# Copyright (C) 2011, Kevin Polulak <kpolulak@gmail.com>.

module Digest::SHA256:<soh-cah-toa 0.1>;

=begin

=head1 NAME

Digest::SHA256 - Perl 6 interface to the SHA256 algorithm

=head1 SYNOPSIS

    use v6;
    use Digest::SHA256;

    my $hex = sha256_hex("foobar");
    say $hex;

=head1 DESCRIPTION

The C<Digest::SHA256> module provides a procedural interface to the 256-bit
Secure Hash Algorithm. The algorithm takes a message of arbitrary length as
input and produces a 256-bit message digest as output.

Note that while the Perl 5 C<SHA256> module provides an object-oriented
interface, C<Digest::SHA256> has a procedural interface. This is subject to
change in future versions.

=head1 SUBROUTINES

The following functions are exported by default.

=over 4

=item B<sha256_hex(Str $msg)>, B<sha256_hex(@msg)>

Takes either a scalar of type C<Str> or a list and concatenates all elements.
Calculates the SHA256 digest and returns it in hexadecimal form.

=item B<sha256_sum(Str $msg)>, B<sha256_sum(@msg)>

This function is still in the process of being developed. Do not bother with
it.

=back

=head1 AUTHOR

C<Digest::SHA256> was written by Kevin Polulak (a.k.a. soh_cah_toa).

The SHA256 hash algorithm was designed by the National Security Agency (NSA)
and published by the National Institute of Standards and Technology (NIST).

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011, Kevin Polulak <kpolulak@gmail.com>.

This program is distributed under the terms of the Artistic License 2.0.

For further information, please see LICENSE or visit 
<http://www.perlfoundation.org/attachment/legal/artistic-2_0.txt>.

=end

=cut

pir::load_bytecode('Digest/sha256.pir');

my $sum   = Q:PIR { %r = get_root_global ['parrot'; 'Digest'], '_sha256sum'    };
my $hex   = Q:PIR { %r = get_root_global ['parrot'; 'Digest'], '_sha256_hex'   };
my $print = Q:PIR { %r = get_root_global ['parrot'; 'Digest'], '_sha256_print' };

multi sub sha256_sum(Str $msg) is export { return $sum.($msg)           }
multi sub sha256_sum(@msg)     is export { return sha256_sum(@msg.join) }

multi sub sha256_hex(Str $msg) is export { return $hex.($sum.($msg))    }
multi sub sha256_hex(@msg)     is export { return sha256_hex(@msg.join) }

      sub sha256_print(@sum)   is export { $print.(@sum)                }

# vim: ft=perl6

