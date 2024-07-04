#!/bin/sh -e
#
# This helper script compiles Normaliz for you.
# To use it, pass the location of your GAP installation
# to it:
#
#  ./prerequisites.sh GAPDIR
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

# make path absolute
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
if [ -n "$GMP_FLAG" ]; then
    echo "Using supplied GMP_FLAG = $GMP_FLAG"
elif test "${GMP_PREFIX+set}" = set; then
    # In GAP >= 4.12.1, we can find out where GAP found GMP
    # by looking at GMP_PREFIX set in sysinfo.gap
    echo "Using GMP_FLAG = $GMP_PREFIX (GMP_PREFIX)"
    GMP_FLAG="$GMP_PREFIX"
else
    echo "No GMP_FLAG found"
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
    # If using an older GAP built with libtool, put in .libs
    if test -d ${GAPDIR}/.libs; then 
        cp ${NormalizInstallDir}/bin/cygnormaliz-*.dll ${GAPDIR}/.libs/
    fi
    # For newer GAP, put in root directory (this is fine for older GAPs)
    cp ${NormalizInstallDir}/bin/cygnormaliz-*.dll "${GAPDIR}/"
fi
