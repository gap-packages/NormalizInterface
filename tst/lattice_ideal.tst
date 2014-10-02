gap> M := [
> [ 2, 1,  0, -1, -1,  -1 ],
> [ 1, 0, -1,  2, -1,  -1 ],
> [ 1, 1,  1,  0, -2,  -1 ],
> ];;
gap> cone := NmzCone(["lattice_ideal", M]);;
gap> NmzCompute(cone, ["DefaultMode"]);
true
gap> NmzPropFingerprint(cone, "OriginalMonoidGenerators");
6
gap> NmzPropFingerprint(cone, "HilbertBasis");
9
gap> NmzPropFingerprint(cone, "Deg1Elements");
9
gap> # TODO: ReesPrimary
gap> NmzPropFingerprint(cone, "ExtremeRays");
5
gap> NmzPropFingerprint(cone, "SupportHyperplanes");
5
gap> NmzEmbeddingDimension(cone);
3
gap> NmzRank(cone);
3
gap> NmzPropFingerprint(cone, "IsIntegrallyClosed");
false
gap> NmzPropFingerprint(cone, "TriangulationSize");
3
gap> NmzPropFingerprint(cone, "TriangulationDetSum");
10
gap> NmzPropFingerprint(cone, "Grading");
[ 1, -1, 1 ]
gap> NmzPropFingerprint(cone, "IsDeg1ExtremeRays");
true
gap> NmzPropFingerprint(cone, "IsDeg1HilbertBasis");
true
gap> NmzPropFingerprint(cone, "Multiplicity");
10
