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

You should use the same GMP version for GAP and libnormaliz. To ensure
this you can use a system installed GMP for GAP by configuring it with

    ./configure --with-gmp=system

and build it. Next you need Normaliz, the easiest way is to clone the master
branch from the Normaliz GitHub repository with the command

    git clone https://github.com/Normaliz/Normaliz Normaliz.git

into this directory. After that you can run the script
    
    ./build_normaliz.sh

Once it completed successfully, you can then build NormalizInterface
like this:

    ./autogen.sh (need autoconf and automake)
    ./configure --with-gaproot=GAPDIR --with-normaliz=$PWD/Normaliz.git/DST
    make

If you need to customize the normaliz compilation have a look at
Normaliz.git/source/INSTALL. Remember to use the same compiler and GMP
version as for GAP.

To be able to run the tests of NormalizInterface install also the GAP package
io. For that go to the pkg/io-x.x.x/ directory and do "./configure" and "make".
See the io package README for more information.


## Documentation and tests

Generate the documentation:
    
    make doc

run automatic tests:
    
    make check
    gap maketest.g


## Bug reports and feature requests

Please submit bug reports and feature requests via our GitHub issue tracker:

  https://github.com/gap-packages/NormalizInterface
