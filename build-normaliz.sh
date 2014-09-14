#!/bin/sh -ev
#
# This helper script compiles Normaliz for you.
# Before using it the first time, clone the "gap" branch of
# the Normaliz git repository:
#    git clone -b gap https://github.com/csoeger/Normaliz Normaliz.git
#
# After that you can run this script ("build-normaliz.sh").
#
# Once it completed successfully, you can then build NormalizInterface
# like this:
#
#  ./configure --with-gaproot=GAPDR --with-normaliz=$PWD/Normaliz.git/DST
#  make
#

cd Normaliz.git

mkdir -p DST
mkdir -p BUILD

PREFIX="$PWD/DST"
cd BUILD
cmake -DCMAKE_INSTALL_PREFIX:PATH="$PREFIX" ../source
make
make install

