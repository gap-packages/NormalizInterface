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
GAP48_GMP="$GAPDIR/bin/$GAParch/extern/gmp"
GAP49_GMP="$GAPDIR/extern/install/gmp"
if [ -n "$GMP_FLAG" ]; then
    echo "Using supplied GMP_FLAG = $GMP_FLAG"
elif [ -f "$GAP48_GMP/MAKE_CHECK_PASSED" -a  -f "$GAP48_GMP/include/gmp.h" ]; then
    # GAP <= 4.8
    echo "ERROR: your GAP is too old, need GAP 4.9 or later"
    exit 1
elif [ -f "$GAP49_GMP/include/gmp.h" ]; then
    # GAP >= 4.9
    echo "GAP >= 4.9 was built with its own GMP"
    if [ -f "$GAP49_GMP/include/gmpxx.h" ]; then
        echo "GAP's GMP includes C++ support"
        GMP_FLAG="$GAP49_GMP"
    else
        echo "ERROR: GAP's GMP was built without C++ support"
        exit 1
    fi
else
    echo "GAP was apparently built with external GMP"
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

# allow overriding the normaliz version via env var or argument, so that
# we can test with many different ones
if [ -z $NORMALIZ_VERSION ]; then
    NORMALIZ_VERSION=3.9.3
    NORMALIZ_SHA256=0288f410428a0eebe10d2ed6795c8906712848c7ae5966442ce164adc2429657
fi
NORMALIZ_BASE=normaliz-${NORMALIZ_VERSION}
NORMALIZ_TAR=${NORMALIZ_BASE}.tar.gz
NORMALIZ_URL=https://github.com/Normaliz/Normaliz/releases/download/v${NORMALIZ_VERSION}/${NORMALIZ_TAR}

echo
echo "##"
echo "## downloading ${NORMALIZ_TAR}"
echo "##"
etc/download.sh ${NORMALIZ_URL} ${NORMALIZ_SHA256}

# extract it
echo
echo "##"
echo "## extracting ${NORMALIZ_TAR}"
echo "##"
rm -rf ${NORMALIZ_BASE}
tar xvf ${NORMALIZ_TAR}

echo "##"
echo "## compiling Normaliz ${NORMALIZ_VERSION}"
echo "##"

# If GAP was build for 32 bit, also do it for normaliz
if [ x$GAParch_abi = x"32-bit" ] || [ x$GAP_ABI = x32 ]; then
    echo "GAP was built for 32 bit"
    export CXXFLAGS="${CXXFLAGS} -m32"
fi

NormalizInstallDir=$PWD/NormalizInstallDir
rm -rf ${NormalizInstallDir}
mkdir -p ${NormalizInstallDir}

cd ${NORMALIZ_BASE}
if [ "x$GMP_FLAG" != "x" ]; then
  ./configure --prefix="${NormalizInstallDir}" --with-gmp=$GMP_FLAG $@
else
  ./configure --prefix="${NormalizInstallDir}" $@
fi
make -j4
make install

osname=$(uname -s)
if [ "${osname#*CYGWIN}" != "$osname" ]; then
    echo "##"
    echo "## Extra Cygwin installation step"
    echo "##"
    # We have to move the Normalize dll to $GAPDIR/.libs, as this is the only
    # place which Cygwin will check for it inside $GAPDIR.
    cp ${NormalizInstallDir}/bin/cygnormaliz-*.dll "${GAPDIR}/.libs"
fi
