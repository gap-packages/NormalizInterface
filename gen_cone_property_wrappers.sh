#!/bin/bash -e

properties="\
AffineDim \
ClassGroup \
Deg1Elements \
Dehomogenization \
ExcludedFaces \
ExtremeRays \
Generators \
Grading \
HilbertBasis \
HilbertQuasiPolynomial \
HilbertSeries \
InclusionExclusionData \
IsDeg1ExtremeRays \
IsDeg1HilbertBasis \
IsIntegrallyClosed \
IsPointed \
ModuleGenerators \
ModuleGeneratorsOverOriginalMonoid \
ModuleRank \
Multiplicity \
OriginalMonoidGenerators \
RecessionRank \
IsReesPrimary \
ReesPrimaryMultiplicity \
SupportHyperplanes \
Triangulation \
TriangulationDetSum \
TriangulationSize \
VerticesOfPolyhedron \
"

# The following cone properties are omitted on purpose:
# Approximate            -- not really a cone property
# BottomDecomposition    -- not really a cone property
# DefaultMode            -- not really a cone property
# DualMode               -- not really a cone property
# KeepOrder              -- not really a cone property
# StanleyDec             -- data conversion not supported at this time

GD_FILE=lib/cone_property_wrappers.gd
GI_FILE=lib/cone_property_wrappers.gi

#
# Create the .gd file
#

cat > $GD_FILE <<EOF
## This is an automatically generated file

#! @Chapter Functions
#! @Section Cone properties
EOF

for prop in $properties ; do
cat  >> $GD_FILE <<EOF
#! @Description
#!  This is an alias for <C>NmzConeProperty( cone, "$prop" );</C>
#! @Arguments cone
DeclareGlobalFunction( "Nmz$prop" );

EOF
done

#
# Create the .gi file
#

cat > $GI_FILE <<EOF
## This is an automatically generated file


EOF

for prop in $properties ; do
cat  >> $GI_FILE <<EOF
InstallGlobalFunction( Nmz$prop, cone -> NmzConeProperty(cone, "$prop" ) );

EOF
done
