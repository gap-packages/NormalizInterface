# The GAP 4 package 'NormalizInterface'

## Package description

Normaliz is a software for computations with rational cones and affine
monoids. It pursues two main computational goals: finding the Hilbert
basis, a minimal generating system of the monoid of lattice points of a
cone; and counting elements degree-wise in a generating function, the
Hilbert series.
As a recent extension, Normaliz can handle unbounded polyhedra. The
Hilbert basis computation can be considered as solving a linear
diophantine system of inhomogeneous equations, inequalities and
congruences.

This package allows creating libnormaliz cone objects from within GAP,
and gives access to it in the GAP environment. In this way GAP can be
used as interactive interface to libnormaliz.

For more information on Normaliz visit
<https://www.normaliz.uni-osnabrueck.de/>
and especially have a look at the manual.


## Installation

NormalizInterface supports GAP 4.8.2 or later, and Normaliz 3.0.0 or later.

Assuming you have a suitable version installed, you still need to
compile Normaliz. There is a complicating factor, however: Normaliz
must be compiled against the exact same version of the GMP library
as GAP. The easiest way to do that is to run the script we provide
to you for just that.  This requires the presence of several further
system software packages, which you could for example install via
your system's package manager. At least the following are required:

 * git
 * cmake
 * boost

Once you have installed these, you can build Normaliz by using
the `build-normaliz.sh` script provided by us. It takes a single,
optional, parameter: the location of the GAP root directory.

    ./build-normaliz.sh GAPDIR

If you omit `GAPDIR`, by default we look in `../..`.

Once the script completed successfully, you can build NormalizInterface
like this:

    ./configure --with-gaproot=GAPDIR
    make

The ` --with-gaproot=GAPDIR` parameter is actually optional, and if omitted,
the package will search for GAP in `../..`.

If you need to customize the Normaliz compilation, please have a look at
`Normaliz.git/source/INSTALL`. Remember to use the same compiler and GMP
version as for GAP.


## Documentation and tests

Generate the documentation:

    make doc

run automatic tests:

    make check
    gap maketest.g


## Bug reports and feature requests

Please submit bug reports and feature requests via our GitHub issue tracker:

  <https://github.com/gap-packages/NormalizInterface/issues>


## License

NormalizInterface is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

For details see the file COPYING.
