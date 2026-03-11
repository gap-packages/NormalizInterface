gap> START_TEST("rp2poly.tst");

#
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
gap> NmzCompute(cone);
true
gap> tmp := NmzKnownConeProperties(cone);;
gap> RemoveSet(tmp, "NumberLatticePoints");
gap> Perform(tmp, Display);
ClassGroup
Deg1Elements
EmbeddingDim
ExtremeRays
Generators
Grading
GradingDenom
HilbertBasis
HilbertQuasiPolynomial
HilbertSeries
InternalIndex
IsDeg1ExtremeRays
IsDeg1HilbertBasis
IsInhomogeneous
IsIntegrallyClosed
IsPointed
IsTriangulationNested
IsTriangulationPartial
MaximalSubspace
Multiplicity
OriginalMonoidGenerators
Rank
Sublattice
SupportHyperplanes
TriangulationDetSum
TriangulationSize
UnitGroupIndex
gap> Display(NmzTriangulation(cone));
[ [ rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 2, 3, 4, 5 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 3, 4, 5, 6 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 3, 4, 6, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 4, 5, 6, 7 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 4, 6, 7, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 4, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 2, 3, 4, 5, 6 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 4, 6, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 2, 3, 4, 5, 7 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 3, 4, 5, 6, 7 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 3, 4, 6, 7, 8 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 3, 4, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 3, 4, 5, 6, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 3, 4, 5, 7, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 3, 4, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 5, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 5, 6, 7, 8 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 6, 7, 8, 9 ],
          mult := 0,
          vol := 1 ) ], 
  [ [ 0, 0, 1, 1, 0, 1 ], [ 0, 0, 1, 1, 1, 0 ], [ 0, 1, 0, 0, 1, 1 ], 
      [ 0, 1, 0, 1, 1, 0 ], [ 0, 1, 1, 0, 0, 1 ], [ 1, 0, 0, 0, 1, 1 ], 
      [ 1, 0, 0, 1, 0, 1 ], [ 1, 0, 1, 0, 1, 0 ], [ 1, 1, 0, 1, 0, 0 ], 
      [ 1, 1, 1, 0, 0, 0 ] ] ]
gap> Display(NmzExtremeRays(cone));
[ [  0,  0,  1,  1,  0,  1 ],
  [  0,  0,  1,  1,  1,  0 ],
  [  0,  1,  0,  0,  1,  1 ],
  [  0,  1,  0,  1,  1,  0 ],
  [  0,  1,  1,  0,  0,  1 ],
  [  1,  0,  0,  0,  1,  1 ],
  [  1,  0,  0,  1,  0,  1 ],
  [  1,  0,  1,  0,  1,  0 ],
  [  1,  1,  0,  1,  0,  0 ],
  [  1,  1,  1,  0,  0,  0 ] ]
gap> Display(NmzSupportHyperplanes(cone));
[ [  -2,   1,   1,   1,   1,   1 ],
  [  -1,  -1,   2,   2,  -1,   2 ],
  [  -1,  -1,   2,   2,   2,  -1 ],
  [  -1,   2,  -1,  -1,   2,   2 ],
  [  -1,   2,  -1,   2,   2,  -1 ],
  [  -1,   2,   2,  -1,  -1,   2 ],
  [   0,   0,   0,   0,   0,   1 ],
  [   0,   0,   0,   0,   1,   0 ],
  [   0,   0,   0,   1,   0,   0 ],
  [   0,   0,   1,   0,   0,   0 ],
  [   0,   1,   0,   0,   0,   0 ],
  [   1,  -2,   1,   1,   1,   1 ],
  [   1,   0,   0,   0,   0,   0 ],
  [   1,   1,  -2,   1,   1,   1 ],
  [   1,   1,   1,  -2,   1,   1 ],
  [   1,   1,   1,   1,  -2,   1 ],
  [   1,   1,   1,   1,   1,  -2 ],
  [   2,  -1,  -1,  -1,   2,   2 ],
  [   2,  -1,  -1,   2,  -1,   2 ],
  [   2,  -1,   2,  -1,   2,  -1 ],
  [   2,   2,  -1,   2,  -1,  -1 ],
  [   2,   2,   2,  -1,  -1,  -1 ] ]
gap> Display(NmzHilbertBasis(cone));
[ [  0,  0,  1,  1,  0,  1 ],
  [  0,  0,  1,  1,  1,  0 ],
  [  0,  1,  0,  0,  1,  1 ],
  [  0,  1,  0,  1,  1,  0 ],
  [  0,  1,  1,  0,  0,  1 ],
  [  1,  0,  0,  0,  1,  1 ],
  [  1,  0,  0,  1,  0,  1 ],
  [  1,  0,  1,  0,  1,  0 ],
  [  1,  1,  0,  1,  0,  0 ],
  [  1,  1,  1,  0,  0,  0 ],
  [  1,  1,  1,  1,  1,  1 ] ]
gap> Display(NmzDeg1Elements(cone));
[ [  0,  0,  1,  1,  0,  1 ],
  [  0,  0,  1,  1,  1,  0 ],
  [  0,  1,  0,  0,  1,  1 ],
  [  0,  1,  0,  1,  1,  0 ],
  [  0,  1,  1,  0,  0,  1 ],
  [  1,  0,  0,  0,  1,  1 ],
  [  1,  0,  0,  1,  0,  1 ],
  [  1,  0,  1,  0,  1,  0 ],
  [  1,  1,  0,  1,  0,  0 ],
  [  1,  1,  1,  0,  0,  0 ] ]
gap> Display(NmzSublattice(cone));
[ [ [ 0, 0, 0, 0, 0, 3 ], [ 1, 0, 0, 0, 0, -1 ], [ 0, 1, 0, 0, 0, -1 ], 
      [ 0, 0, 1, 0, 0, -1 ], [ 0, 0, 0, 1, 0, -1 ], [ 0, 0, 0, 0, 1, -1 ] ], 
  [ [ 1, 3, 0, 0, 0, 0 ], [ 1, 0, 3, 0, 0, 0 ], [ 1, 0, 0, 3, 0, 0 ], 
      [ 1, 0, 0, 0, 3, 0 ], [ 1, 0, 0, 0, 0, 3 ], [ 1, 0, 0, 0, 0, 0 ] ], 3 ]
gap> Display(NmzOriginalMonoidGenerators(cone));
[ [  1,  1,  1,  0,  0,  0 ],
  [  1,  1,  0,  1,  0,  0 ],
  [  1,  0,  1,  0,  1,  0 ],
  [  1,  0,  0,  1,  0,  1 ],
  [  1,  0,  0,  0,  1,  1 ],
  [  0,  1,  1,  0,  0,  1 ],
  [  0,  1,  0,  1,  1,  0 ],
  [  0,  1,  0,  0,  1,  1 ],
  [  0,  0,  1,  1,  1,  0 ],
  [  0,  0,  1,  1,  0,  1 ] ]
gap> NmzConeProperty(cone, "BasicTriangulation");
fail
gap> NmzConeProperty(cone, "ClassGroup");
[ 16 ]
gap> NmzConeProperty(cone, "EhrhartQuasiPolynomial");
[ [ 120, 314, 375, 265, 105, 21 ], 120 ]
gap> NmzConeProperty(cone, "EmbeddingDim");
6
gap> NmzConeProperty(cone, "Grading");
[ 1/3, 1/3, 1/3, 1/3, 1/3, 1/3 ]
gap> NmzConeProperty(cone, "GradingDenom");
3
gap> NmzConeProperty(cone, "HilbertQuasiPolynomial");
[ 7/40*t^5+7/8*t^4+53/24*t^3+25/8*t^2+157/60*t+1 ]
gap> NmzConeProperty(cone, "HilbertQuasiPolynomial");
[ 7/40*t^5+7/8*t^4+53/24*t^3+25/8*t^2+157/60*t+1 ]
gap> NmzConeProperty(cone, "HilbertSeries");
[ t^4+4*t^3+11*t^2+4*t+1, [ [ 1, 6 ] ] ]
gap> NmzConeProperty(cone, "InternalIndex");
1
gap> NmzConeProperty(cone, "IsDeg1ExtremeRays");
true
gap> NmzConeProperty(cone, "IsDeg1HilbertBasis");
false
gap> NmzConeProperty(cone, "IsInhomogeneous");
false
gap> NmzConeProperty(cone, "IsIntegrallyClosed");
false
gap> NmzConeProperty(cone, "IsPointed");
true
gap> NmzConeProperty(cone, "IsTriangulationNested");
false
gap> NmzConeProperty(cone, "IsTriangulationPartial");
false
gap> NmzConeProperty(cone, "MaximalSubspace");
[  ]
gap> NmzConeProperty(cone, "Multiplicity");
21
gap> NmzConeProperty(cone, "Rank");
6
gap> NmzConeProperty(cone, "TriangulationDetSum");
21
gap> NmzConeProperty(cone, "TriangulationSize");
18
gap> NmzConeProperty(cone, "UnitGroupIndex");
1
gap> Display(NmzConeDecomposition(cone));
[ [ rec(
          Excluded := [ false, false, false, false, false, false ],
          height := 0,
          key := [ 0, 1, 2, 3, 4, 5 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ false, true, false, false, false, true ],
          height := 0,
          key := [ 0, 1, 3, 4, 5, 6 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ true, false, false, false, false, true ],
          height := 0,
          key := [ 0, 1, 3, 4, 6, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ true, false, false, false, false, true ],
          height := 0,
          key := [ 0, 1, 4, 5, 6, 7 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ true, false, false, false, true, true ],
          height := 0,
          key := [ 0, 1, 4, 6, 7, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ true, true, false, false, false, true ],
          height := 0,
          key := [ 0, 1, 4, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ false, false, false, false, false, true ],
          height := 0,
          key := [ 0, 2, 3, 4, 5, 6 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ true, false, false, false, false, true ],
          height := 0,
          key := [ 0, 4, 6, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ false, false, false, false, false, true ],
          height := 0,
          key := [ 1, 2, 3, 4, 5, 7 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ false, false, false, false, true, true ],
          height := 0,
          key := [ 1, 3, 4, 5, 6, 7 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [ true, false, false, false, false, true ],
          height := 0,
          key := [ 1, 3, 4, 6, 7, 8 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [ true, false, false, false, false, true ],
          height := 0,
          key := [ 1, 3, 4, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ true, false, false, false, false, true ],
          height := 0,
          key := [ 2, 3, 4, 5, 6, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ true, false, false, false, true, true ],
          height := 0,
          key := [ 2, 3, 4, 5, 7, 8 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ false, true, false, false, false, true ],
          height := 0,
          key := [ 2, 3, 4, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ false, false, false, false, false, true ],
          height := 0,
          key := [ 2, 4, 5, 7, 8, 9 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [ false, false, false, false, false, true ],
          height := 0,
          key := [ 3, 4, 5, 6, 7, 8 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [ false, false, true, false, false, true ],
          height := 0,
          key := [ 4, 5, 6, 7, 8, 9 ],
          mult := 0,
          vol := 1 ) ], 
  [ [ 0, 0, 1, 1, 0, 1 ], [ 0, 0, 1, 1, 1, 0 ], [ 0, 1, 0, 0, 1, 1 ], 
      [ 0, 1, 0, 1, 1, 0 ], [ 0, 1, 1, 0, 0, 1 ], [ 1, 0, 0, 0, 1, 1 ], 
      [ 1, 0, 0, 1, 0, 1 ], [ 1, 0, 1, 0, 1, 0 ], [ 1, 1, 0, 1, 0, 0 ], 
      [ 1, 1, 1, 0, 0, 0 ] ] ]
gap> ForAll(NmzConeDecomposition(cone), IsBlistRep);
false

#
gap> STOP_TEST("rp2poly.tst", 0);
