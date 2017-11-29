#!/bin/sh -e
#
# This helper script compiles Normaliz for you.
# To use it, pass the location of your GAP installation
# to it:
#
#  ./build-normaliz.sh GAPDIR
#
#  Then you can compile NormalizInterface as follows:
#
#  ./configure --with-gaproot=GAPDIR
#  make
#

if [ "$#" -ge 1 ]; then
    GAPDIR=$1
    shift
else
    GAPDIR=../..
fi

# make path absolut
SCRIPTDIR=$PWD
cd $GAPDIR
GAPDIR=$PWD
cd $SCRIPTDIR

# check for presence of GAP and determine value of GAParch
if [ ! -f "$GAPDIR/sysinfo.gap" ]; then
    echo "ERROR: could not locate GAP in directory $GAPDIR"
    exit 1
fi;
. "$GAPDIR/sysinfo.gap"

echo "Found GAP in directory $GAPDIR"
echo "GAParch = $GAParch"

# check if GAP was built with its own GMP (this is kind of a hack...)
GAP_GMP="$GAPDIR/bin/$GAParch/extern/gmp"
if [ -f "$GAP_GMP/MAKE_CHECK_PASSED" -a  -f "$GAP_GMP/include/gmp.h" ]; then
    echo "GAP was built with its own GMP"
    if [ -f "$GAP_GMP/include/gmpxx.h" ]; then
        echo "GAP's GMP includes C++ support"
        GMP_FLAG="$GAP_GMP"
    else
        echo "ERROR: GAP's GMP was built without C++ support"
        exit 1
    fi
else
    echo "GAP was built with external GMP"
    # TODO: actually, now we should figure out somehow which
    # external GMP library was used to build GAP. But that's not really
    # possible: While we could e.g. scan the "internal" sysinfo.gap
    # file for the "gap_config_options" string, and in there
    # look for an "--with-gmp", this is not entirely reliable by
    # itself (partially due to bugs in the GAP build system).
    #
    # So, we do not even try to figure out details, and instead
    # cross our fingers and hope for the best.
    #
    # Expert users can help with that, of course, by setting
    # the GMP_DIR variable manually.
fi

NORMALIZ_VERSION=v3.4.0

# needs git 1.8 or newer
if [ ! -d Normaliz.git ]; then
    echo "Fetching Normaliz source code"
    git clone --depth 1 --branch $NORMALIZ_VERSION -- https://github.com/Normaliz/Normaliz Normaliz.git
fi
cd Normaliz.git
# get a new version
if [ `git describe --tags` != $NORMALIZ_VERSION ]; then
    git fetch origin $NORMALIZ_VERSION
    git fetch origin
    git checkout $NORMALIZ_VERSION
fi

rm -rf DST
mkdir -p DST

# The cmake build process honors environment variables like
# GMP_DIR and BOOST_ROOT. So if you need to tell the build
# process where to find GMP and Boost, you can invoke this
# script like this:
#
#  GMP_DIR=/some/path BOOST_ROOT=/another/path ./build-normaliz.sh $GAPROOT

# If GAP was build for 32 bit, also do it for normaliz
if [ x$GAParch_abi = x"32-bit" ] || [ x$GAP_ABI = x32 ]; then
    echo "GAP was build for 32 bit"
    export CXXFLAGS="-m32"
fi

## use the libtool build system

PREFIX="$PWD/DST"
./bootstrap.sh
if [ "x$GMP_FLAG" != "x" ]; then
  ./configure --prefix=$PREFIX --with-gmp=$GMP_FLAG $@
else
  ./configure --prefix=$PREFIX $@
fi
make
make install
