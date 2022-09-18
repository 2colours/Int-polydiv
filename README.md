[![Actions Status](https://github.com/2colours/Int-polydiv/actions/workflows/test.yml/badge.svg)](https://github.com/2colours/Int-polydiv/actions)

NAME
====

Int::polydiv - the counterpart of the polymod method

SYNOPSIS
========

```raku
use Int::polydiv;

my $amount = 596; # 596 dollars
my @denominations = (1, 2, 5, 10, 20, 50, 100); # the denominations used to pay
$amount.polydiv(@denominations.skip.reverse) Z @denominations.reverse andthen .map({ "$_[0]x$_[1]\$" }).join(' ').say;
# 5x100$ 1x50$ 2x20$ 0x10$ 1x5$ 0x2$ 1x1$
```

DESCRIPTION
===========

Int::polydiv is a module that adds the `polydiv` method on Int itself.

It is a proof-of-concept for a method that I'd like to see in the core language as a natural counterpart of the `polymod` method. For both methods, the user has to provide a list of divisors. In the case of `polymod`, the dividends are obtained by performing integer division on the previous dividend, starting from `self`, and the return value is a sequence of the corresponding remainders. `polydiv` is the opposite: the dividends are obtained as the remainders and the return value elements are obtained as the quotient.

This approach allows for distributing an amount into units that don't include each other perfectly - but it also means that the sizes of the units must be provided relative to the base unit instead of the next unit.

AUTHOR
======

Polgár Márton <polgar@astron.hu>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Polgár Márton

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

