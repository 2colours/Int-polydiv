unit class Int::polydiv;
use MONKEY-TYPING;
augment class Int {
    method polydiv(Int:D: +@divs --> Seq:D){
        fail X::OutOfRange.new(
          :what('invocant to polydiv'), :got(self), :range<0..^Inf>
        ) if self < 0;
    
        gather {
            my $more = self;
            if @divs.is-lazy {
                for @divs -> $div {
                    $more
                      ?? $div
                        ?? take $more div $div
                        !! X::Numeric::DivideByZero.new(
                             using => 'polydiv', numerator => $more
                           ).Failure
                      !! last;
                    $more mod= $div;
                }
                .take if .so given $more;
            }
            else {
                for @divs -> $div {
                    $div
                      ?? take $more div $div
                      !! X::Numeric::DivideByZero.new(
                           using => 'polydiv', numerator => $more
                         ).Failure;
                    $more mod= $div;
                }
                take $more;
            }
        }
    }
}


=begin pod

=head1 NAME

Int::polydiv - the counterpart of the polymod method

=head1 SYNOPSIS

=begin code :lang<raku>

use Int::polydiv;

my $amount = 596; # 596 dollars
my @denominations = (1, 2, 5, 10, 20, 50, 100); # the denominations used to pay
$amount.polydiv(@denominations.skip.reverse) Z @denominations.reverse andthen .map({ "$_[0]x$_[1]\$" }).join(' ').say;
# 5x100$ 1x50$ 2x20$ 0x10$ 1x5$ 0x2$ 1x1$

=end code

=head1 DESCRIPTION

Int::polydiv is a module that adds the `polydiv` method on Int itself.

It is a proof-of-concept for a method that I'd like to see in the core language as a natural counterpart of the `polymod` method.
For both methods, the user has to provide a list of divisors. In the case of `polymod`, the dividends are obtained by performing integer division on the previous dividend, starting from `self`, and the return value is a sequence of the corresponding remainders. `polydiv` is the opposite: the dividends are obtained as the remainders and the return value elements are obtained as the quotient.

This approach allows for distributing an amount into units that don't include each other perfectly - but it also means that the sizes of the units must be provided relative to the base unit instead of the next unit.

=head1 AUTHOR

Polgár Márton <polgar@astron.hu>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Polgár Márton

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
