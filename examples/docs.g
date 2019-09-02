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
#! [ "Generators", "OriginalMonoidGenerators", "InternalIndex", "EmbeddingDim", 
#!   "IsInhomogeneous", "Sublattice" ]
#! @EndExample
#! @EndChunk

#! @BeginChunk NmzCompute_example
#! @BeginExample
NmzKnownConeProperties(cone);
#! [ "Generators", "OriginalMonoidGenerators", "InternalIndex", "EmbeddingDim", 
#!   "IsInhomogeneous", "Sublattice" ]
NmzCompute(cone, ["SupportHyperplanes", "IsPointed"]);
#! true
NmzKnownConeProperties(cone);
#! [ "Generators", "ExtremeRays", "SupportHyperplanes", 
#!   "OriginalMonoidGenerators", "MaximalSubspace", "InternalIndex", "Rank", 
#!   "EmbeddingDim", "IsPointed", "IsDeg1ExtremeRays", "IsInhomogeneous", 
#!   "Sublattice" ]
NmzCompute(cone);;
NmzKnownConeProperties(cone);
#! [ "Generators", "ExtremeRays", "SupportHyperplanes", "HilbertBasis", 
#!   "OriginalMonoidGenerators", "MaximalSubspace", "ClassGroup", 
#!   "TriangulationDetSum", "UnitGroupIndex", "InternalIndex", 
#!   "TriangulationSize", "Rank", "EmbeddingDim", "IsPointed", 
#!   "IsDeg1ExtremeRays", "IsIntegrallyClosed", "IsInhomogeneous", "Sublattice", 
#!   "IsTriangulationNested", "IsTriangulationPartial" ]
#! @EndExample
#! @EndChunk
