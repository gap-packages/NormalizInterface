gap> # Based on dual.in
gap> M := [
> [ 0,  0,  0,  1,  0,  0,  0 ],
> [ 0,  0,  0,  0,  1,  0,  0 ],
> [ 0,  0,  0,  0,  0,  1,  0 ],
> [ 0,  0,  0,  0,  0,  0,  1 ],
> [ 0,  0,  1,  0,  0,  0,  0 ],
> [ 0,  1,  0,  0,  0,  0,  0 ],
> [ 0,  1,  0,  1,  1,  0, -1 ],
> [ 0,  1,  0,  0,  1,  1, -1 ],
> [ 0,  1,  1,  0,  0,  1, -1 ],
> [ 0,  0,  1,  1,  1,  0, -1 ],
> [ 0,  0,  1,  1,  0,  1, -1 ],
> [ 0,  1,  1,  1,  1,  1, -2 ],
> [ 1,  0,  0,  0,  0,  0,  0 ],
> [ 1,  1,  1,  1,  1,  1, -3 ],
> [ 1,  0,  0,  1,  0,  1, -1 ],
> [ 1,  0,  0,  0,  1,  1, -1 ],
> [ 1,  0,  1,  0,  1,  0, -1 ],
> [ 1,  0,  1,  1,  1,  1, -2 ],
> [ 1,  1,  0,  1,  0,  0, -1 ],
> [ 1,  1,  1,  0,  0,  0, -1 ],
> [ 1,  1,  1,  1,  0,  1, -2 ],
> [ 1,  1,  1,  0,  1,  1, -2 ],
> [ 1,  1,  1,  1,  1,  0, -2 ],
> [ 1,  1,  0,  1,  1,  1, -2 ],
> ];;
gap> cone := NmzCone(["hyperplanes", M]);;
gap> NmzCompute(cone, ["DefaultMode"]);
true
gap> NmzPropFingerprint(cone, "OriginalMonoidGenerators");
16
gap> NmzPropFingerprint(cone, "HilbertBasis");
17
gap> NmzPropFingerprint(cone, "Deg1Elements");
16
gap> NmzPropFingerprint(cone, "ExtremeRays");
16
gap> NmzPropFingerprint(cone, "SupportHyperplanes");
24
gap> NmzEmbeddingDimension(cone);
7
gap> NmzRank(cone);
7
gap> NmzPropFingerprint(cone, "IsIntegrallyClosed");
false
gap> NmzPropFingerprint(cone, "TriangulationSize");
69
gap> NmzPropFingerprint(cone, "TriangulationDetSum");
72
gap> NmzPropFingerprint(cone, "Grading");
[ 1, 1, 1, 1, 1, 1, -2 ]
gap> NmzPropFingerprint(cone, "IsDeg1ExtremeRays");
true
gap> NmzPropFingerprint(cone, "IsDeg1HilbertBasis");
false
gap> NmzPropFingerprint(cone, "Multiplicity");
72
