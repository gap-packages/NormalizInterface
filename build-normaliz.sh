#!/bin/sh -ev
#
# This helper script compiles Normaliz for you.
# Before using it the first time, clone the "master" branch of
# the Normaliz git repository:
#    git clone https://github.com/Normaliz/Normaliz Normaliz.git
#
# After that you can run this script ("build-normaliz.sh").
#
# Once it completed successfully, you can then build NormalizInterface
# like this:
#
#  ./configure --with-gaproot=GAPDIR --with-normaliz=$PWD/Normaliz.git/DST
#  make
#

cd Normaliz.git

rm -rf DST
rm -rf BUILD
mkdir -p DST
mkdir -p BUILD

PREFIX="$PWD/DST"
cd BUILD
cmake -DCMAKE_INSTALL_PREFIX:PATH="$PREFIX" ../source
make
make install

