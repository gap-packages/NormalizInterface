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
and gives access to it in the GAP enviroment. In this way GAP can be
used as interactive interface to libnormaliz.

For more information on Normaliz visit http://www.math.uos.de/normaliz and
especially have a look at the manual.


## Installation preparation

NormalizInterface supports GAP 4.8.0 or later, and Normaliz 3.0.0 or later.

For technical reasons, installing and using NormalizInterface requires
that your version of GAP is compiled in a special way. Specifically, GAP
must be compiled against the exact same version of the GMP library as
Normaliz. By default, GAP compiles its own version of GMP; however, we
cannot use that, as it lacks C++ support, which is required by Normaliz.

Thus as the very first step, please install a version of GMP in your
system. On most Linux and BSD distributions, there should be a GMP
package available with your system's package manager. On Mac OS X, you
can install GMP via Fink, MacPorts or Homebrew.

Next, make sure your GAP installation is compiled against the system
wide GMP installation. To do so, switch to the GAP root directory, and
enter the following commands:

    make clean
    ./configure --with-gmp=system
    make

Next you need to compile a recent version of Normaliz. This requires the
presence of several further system software packages, which you install
via your system's package manager. At least the following are required:

 * git
 * cmake
 * boost

Once you have installed these, you can build Normaliz by using
the build-normaliz.sh script we provide. It takes a single,
optional parameter: the location of the GAP root directory.
    
    ./build-normaliz.sh GAPDIR

Once it completed successfully, you can then build NormalizInterface
like this:

    ./configure --with-gaproot=GAPDIR
    make

If you need to customize the normaliz compilation, please have a look at
Normaliz.git/source/INSTALL. Remember to use the same compiler and GMP
version as for GAP.


## Documentation and tests

Generate the documentation:
    
    make doc

run automatic tests:
    
    make check
    gap maketest.g


## Bug reports and feature requests

Please submit bug reports and feature requests via our GitHub issue tracker:

  https://github.com/gap-packages/NormalizInterface
