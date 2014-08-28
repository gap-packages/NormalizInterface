#!/bin/bash

property_list="Generators ExtremeRays SupportHyperplanes TriangulationSize TriangulationDetSum Triangulation \
Multiplicity HilbertBasis Deg1Elements HilbertSeries Grading IsPointed IsDeg1Generated IsDeg1ExtremeRays \
IsDeg1HilbertBasis IsIntegrallyClosed GeneratorsOfToricRing ReesPrimary ReesPrimaryMultiplicity StanleyDec DualMode"

echo "## This is an automatically generated file" > lib/cone_property_function.gd
echo "" >> lib/cone_property_function.gd
echo "" >> lib/cone_property_function.gd

echo "## This is an automatically generated file" > lib/cone_property_function.gi
echo "" >> lib/cone_property_function.gi
echo "" >> lib/cone_property_function.gi

for i in $property_list
  do
    sed s/{{PropertyString}}/$i/g < templates/cone_property_function.gd.tpl >> lib/cone_property_function.gd
    echo "" >> lib/cone_property_function.gd
    echo "" >> lib/cone_property_function.gd
    sed s/{{PropertyString}}/$i/g < templates/cone_property_function.gi.tpl >> lib/cone_property_function.gi
    echo "" >> lib/cone_property_function.gi
    echo "" >> lib/cone_property_function.gi
done