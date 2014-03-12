gap> M := [
> [  1,  1,  2 ],
> [ -1, -1,  3 ],
> [  1, -2,  4 ],
> ];;
gap> gr := [ [ 0, 0, 1 ] ];;
gap> cone := NmzCone(["integral_closure", M, "grading", gr]);;
gap> NmzCompute(cone, ["DefaultMode"]);
true
gap> NmzPropFingerprint(cone, "GeneratorsOfToricRing");
fail
gap> NmzPropFingerprint(cone, "HilbertBasis");
8
gap> NmzPropFingerprint(cone, "Deg1Elements");
1
gap> # TODO: ReesPrimary
gap> NmzPropFingerprint(cone, "ExtremeRays");
3
gap> NmzPropFingerprint(cone, "SupportHyperplanes");
3
gap> NmzDimension(cone);
3
gap> NmzBasisChangeRank(cone);
3
gap> NmzBasisChangeIndex(cone);
15
gap> NmzPropFingerprint(cone, "IsIntegrallyClosed");
false
gap> NmzPropFingerprint(cone, "TriangulationSize");
1
gap> NmzPropFingerprint(cone, "TriangulationDetSum");
15
gap> NmzPropFingerprint(cone, "Grading");
[ 0, 0, 1 ]
gap> NmzPropFingerprint(cone, "IsDeg1ExtremeRays");
false
gap> NmzPropFingerprint(cone, "IsDeg1HilbertBasis");
false
gap> NmzPropFingerprint(cone, "Multiplicity");
5/8
