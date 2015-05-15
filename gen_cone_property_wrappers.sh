#!/bin/bash -e

properties="\
AffineDim \
DefaultMode \
Deg1Elements \
Dehomogenization \
DualMode \
ExcludedFaces \
ExtremeRays \
Generators \
Grading \
HilbertBasis \
HilbertFunction \
HilbertSeries \
IsDeg1ExtremeRays \
IsDeg1HilbertBasis \
IsIntegrallyClosed \
IsPointed \
ModuleGenerators \
ModuleRank \
Multiplicity \
OriginalMonoidGenerators \
RecessionRank \
ReesPrimary \
ReesPrimaryMultiplicity \
Shift \
SupportHyperplanes \
Triangulation \
TriangulationDetSum \
TriangulationSize \
VerticesOfPolyhedron \
"

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
