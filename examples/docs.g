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
#! [ "EmbeddingDim", "Generators", "InternalIndex", "IsInhomogeneous", 
#!   "OriginalMonoidGenerators", "Sublattice" ]
#! @EndExample
#! @EndChunk

#! @BeginChunk NmzCompute_example
#! @BeginExample
NmzKnownConeProperties(cone);
#! [ "EmbeddingDim", "Generators", "InternalIndex", "IsInhomogeneous", 
#!   "OriginalMonoidGenerators", "Sublattice" ]
NmzCompute(cone, ["SupportHyperplanes", "IsPointed"]);
#! true
NmzKnownConeProperties(cone);
#! [ "EmbeddingDim", "ExtremeRays", "Generators", "InternalIndex", 
#!   "IsDeg1ExtremeRays", "IsInhomogeneous", "IsPointed", "MaximalSubspace", 
#!   "OriginalMonoidGenerators", "Rank", "Sublattice", "SupportHyperplanes" ]
NmzCompute(cone);;
NmzKnownConeProperties(cone);
#! [ "ClassGroup", "EmbeddingDim", "ExtremeRays", "Generators", "HilbertBasis", 
#!   "InternalIndex", "IsDeg1ExtremeRays", "IsInhomogeneous", 
#!   "IsIntegrallyClosed", "IsPointed", "IsTriangulationNested", 
#!   "IsTriangulationPartial", "MaximalSubspace", "OriginalMonoidGenerators", 
#!   "Rank", "Sublattice", "SupportHyperplanes", "TriangulationDetSum", 
#!   "TriangulationSize", "UnitGroupIndex" ]
#! @EndExample
#! @EndChunk
