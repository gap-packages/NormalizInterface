#! @BeginChunk NmzCone_example
#! @BeginExample
cone := NmzCone(["integral_closure",[[2,1],[1,3]]]);
#! <a Normaliz cone>
#! @EndExample
#! @EndChunk

#! @BeginChunk NmzHasConeProperty_example
#! @BeginExample
NmzHasConeProperty(cone, "ExtremeRays");
#! false
#! @EndExample
#! @EndChunk

#! @BeginChunk NmzKnownConeProperties_example
#! @BeginExample
NmzKnownConeProperties(cone);
#! [ "Generators", "OriginalMonoidGenerators", "Sublattice" ]
#! @EndExample
#! @EndChunk

#! @BeginChunk NmzCompute_example
#! @BeginExample
NmzKnownConeProperties(cone);
#! [ "Generators", "OriginalMonoidGenerators", "Sublattice" ]
NmzCompute(cone, ["SupportHyperplanes", "IsPointed"]);
#! true
NmzKnownConeProperties(cone);
#! [ "Generators", "ExtremeRays", "SupportHyperplanes", "IsPointed",
#!   "IsDeg1ExtremeRays", "OriginalMonoidGenerators", "Sublattice",
#!   "MaximalSubspace" ]
NmzCompute(cone);
#! true
NmzKnownConeProperties(cone);
#! [ "Generators", "ExtremeRays", "SupportHyperplanes", "TriangulationSize",
#!   "TriangulationDetSum", "HilbertBasis", "IsPointed", "IsDeg1ExtremeRays",
#!   "IsIntegrallyClosed", "OriginalMonoidGenerators", "Sublattice",
#!   "ClassGroup", "MaximalSubspace"]
#! @EndExample
#! @EndChunk
