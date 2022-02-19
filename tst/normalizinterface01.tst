# NormalizInterface, chapter 2
#
# DO NOT EDIT THIS FILE - EDIT EXAMPLES IN THE SOURCE INSTEAD!
#
# This file has been generated by AutoDoc. It contains examples extracted from
# the package documentation. Each example is preceded by a comment which gives
# the name of a GAPDoc XML file and a line range from which the example were
# taken. Note that the XML file in turn may have been generated by AutoDoc
# from some other input.
#
gap> START_TEST("normalizinterface01.tst");

# /doc/_Chunks.xml:163-166
gap> cone := NmzCone(["integral_closure",[[2,1],[1,3]]]);
<a Normaliz cone>

# /doc/_Chunks.xml:120-123
gap> NmzHasConeProperty(cone, "ExtremeRays");
false

# /doc/_Chunks.xml:129-133
gap> NmzKnownConeProperties(cone);
[ "EmbeddingDim", "Generators", "InternalIndex", "IsInhomogeneous", 
  "OriginalMonoidGenerators", "Sublattice" ]

# /doc/_Chunks.xml:139-157
gap> NmzKnownConeProperties(cone);
[ "EmbeddingDim", "Generators", "InternalIndex", "IsInhomogeneous", 
  "OriginalMonoidGenerators", "Sublattice" ]
gap> NmzCompute(cone, ["SupportHyperplanes", "IsPointed"]);
true
gap> NmzKnownConeProperties(cone);
[ "EmbeddingDim", "ExtremeRays", "Generators", "InternalIndex", 
  "IsDeg1ExtremeRays", "IsInhomogeneous", "IsPointed", "MaximalSubspace", 
  "OriginalMonoidGenerators", "Rank", "Sublattice", "SupportHyperplanes" ]
gap> NmzCompute(cone);;
gap> NmzKnownConeProperties(cone);
[ "ClassGroup", "EmbeddingDim", "ExtremeRays", "Generators", "HilbertBasis", 
  "InternalIndex", "IsDeg1ExtremeRays", "IsInhomogeneous", 
  "IsIntegrallyClosed", "IsPointed", "IsTriangulationNested", 
  "IsTriangulationPartial", "MaximalSubspace", "OriginalMonoidGenerators", 
  "Rank", "Sublattice", "SupportHyperplanes", "TriangulationDetSum", 
  "TriangulationSize", "UnitGroupIndex" ]

#
gap> STOP_TEST("normalizinterface01.tst", 1);
