gap> M := [
> [ 1, 1, 1, 0, 0, 0 ],
> [ 1, 1, 0, 1, 0, 0 ],
> [ 1, 0, 1, 0, 1, 0 ],
> [ 1, 0, 0, 1, 0, 1 ],
> [ 1, 0, 0, 0, 1, 1 ],
> [ 0, 1, 1, 0, 0, 1 ],
> [ 0, 1, 0, 1, 1, 0 ],
> [ 0, 1, 0, 0, 1, 1 ],
> [ 0, 0, 1, 1, 1, 0 ],
> [ 0, 0, 1, 1, 0, 1 ],
> ];;
gap> cone := NmzCone(["normalization", M]);;
gap> NmzCompute(cone, ["DefaultMode"]);
true
gap> NmzPropFingerprint(cone, "OriginalMonoidGenerators");
10
gap> NmzPropFingerprint(cone, "HilbertBasis");
11
gap> NmzPropFingerprint(cone, "Deg1Elements");
10
gap> # TODO: ReesPrimary
gap> NmzPropFingerprint(cone, "ExtremeRays");
10
gap> NmzPropFingerprint(cone, "SupportHyperplanes");
22
gap> NmzDimension(cone);
6
gap> NmzBasisChangeRank(cone);
6
gap> NmzBasisChangeIndex(cone);
1
gap> NmzPropFingerprint(cone, "IsIntegrallyClosed");
false
gap> NmzPropFingerprint(cone, "TriangulationSize");
18
gap> NmzPropFingerprint(cone, "TriangulationDetSum");
21
gap> NmzPropFingerprint(cone, "Grading");
[ 1, 1, 1, 1, 1, 1 ]
gap> NmzPropFingerprint(cone, "IsDeg1ExtremeRays");
true
gap> NmzPropFingerprint(cone, "IsDeg1HilbertBasis");
false
gap> NmzPropFingerprint(cone, "Multiplicity");
21
