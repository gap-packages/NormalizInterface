gap> START_TEST("rproj2.tst");

#
gap> M := [
> [ 1, 0, 0, 0, 0, 0, 0 ],
> [ 0, 1, 0, 0, 0, 0, 0 ],
> [ 0, 0, 1, 0, 0, 0, 0 ],
> [ 0, 0, 0, 1, 0, 0, 0 ],
> [ 0, 0, 0, 0, 1, 0, 0 ],
> [ 0, 0, 0, 0, 0, 1, 0 ],
> [ 1, 1, 1, 0, 0, 0, 1 ],
> [ 1, 1, 0, 1, 0, 0, 1 ],
> [ 1, 0, 1, 0, 1, 0, 1 ],
> [ 1, 0, 0, 1, 0, 1, 1 ],
> [ 1, 0, 0, 0, 1, 1, 1 ],
> [ 0, 1, 1, 0, 0, 1, 1 ],
> [ 0, 1, 0, 1, 1, 0, 1 ],
> [ 0, 1, 0, 0, 1, 1, 1 ],
> [ 0, 0, 1, 1, 1, 0, 1 ],
> [ 0, 0, 1, 1, 0, 1, 1 ],
> ];;
gap> cone := NmzCone(["integral_closure", M]);;
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
          key := [ 0, 1, 2, 3, 4, 6, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 2, 4, 6, 7, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 2, 4, 7, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 3, 4, 6, 7, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 1, 3, 4, 7, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 2, 4, 6, 7, 10, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 2, 4, 7, 10, 11, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 3, 4, 6, 7, 9, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 3, 4, 7, 9, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 4, 6, 7, 9, 10, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 0, 4, 7, 9, 10, 11, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 2, 3, 4, 5, 6, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 2, 4, 5, 6, 7, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 2, 4, 5, 7, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 2, 5, 6, 7, 8, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 2, 5, 7, 8, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 3, 4, 5, 6, 7, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 3, 4, 5, 7, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 3, 5, 6, 7, 10, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 3, 5, 7, 10, 11, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 5, 6, 7, 8, 10, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 1, 5, 7, 8, 10, 11, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 3, 4, 5, 6, 10, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 5, 6, 7, 8, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 5, 6, 8, 10, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 5, 7, 8, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 5, 8, 10, 11, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 5, 8, 10, 12, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 6, 7, 8, 10, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 6, 8, 10, 12, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 2, 4, 7, 8, 10, 11, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 5, 6, 7, 9, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 5, 6, 9, 10, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 5, 7, 9, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 5, 9, 10, 11, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 5, 9, 10, 13, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 5, 9, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 4, 9, 10, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 5, 6, 7, 9, 10, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 5, 6, 9, 10, 13, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 5, 6, 9, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 5, 7, 9, 10, 11, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 3, 6, 9, 10, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 6, 7, 8, 9, 10 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 6, 8, 9, 10, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 7, 8, 9, 10, 11 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 8, 9, 10, 11, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 8, 9, 10, 12, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 9, 10, 11, 12, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 5, 9, 10, 12, 13, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 6, 7, 8, 9, 10, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 6, 8, 9, 10, 12, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 7, 8, 9, 10, 11, 12 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 4, 9, 10, 12, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 5, 6, 7, 8, 9, 10, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 5, 6, 8, 9, 10, 13, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 5, 6, 8, 9, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 5, 7, 8, 9, 10, 11, 13 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 5, 8, 9, 10, 11, 12, 13 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 5, 8, 9, 10, 12, 13, 14 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 6, 7, 8, 9, 10, 12, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 6, 7, 8, 9, 10, 13, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 6, 7, 8, 9, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 6, 7, 9, 10, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 7, 8, 9, 10, 11, 12, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 7, 8, 9, 10, 11, 13, 14 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 7, 9, 10, 11, 13, 14, 15 ],
          mult := 0,
          vol := 1 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 8, 9, 10, 11, 12, 13, 14 ],
          mult := 0,
          vol := 2 ), rec(
          Excluded := [  ],
          height := 0,
          key := [ 9, 10, 11, 12, 13, 14, 15 ],
          mult := 0,
          vol := 1 ) ], 
  [ [ 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 1, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0 ],
      [ 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 1, 0, 1, 1 ], 
      [ 0, 0, 1, 1, 1, 0, 1 ], [ 0, 1, 0, 0, 0, 0, 0 ], 
      [ 0, 1, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 1, 0, 1 ], 
      [ 0, 1, 1, 0, 0, 1, 1 ], [ 1, 0, 0, 0, 0, 0, 0 ], 
      [ 1, 0, 0, 0, 1, 1, 1 ], [ 1, 0, 0, 1, 0, 1, 1 ], 
      [ 1, 0, 1, 0, 1, 0, 1 ], [ 1, 1, 0, 1, 0, 0, 1 ], 
      [ 1, 1, 1, 0, 0, 0, 1 ] ] ]
gap> Display(NmzExtremeRays(cone));
[ [  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  1,  1,  0,  1,  1 ],
  [  0,  0,  1,  1,  1,  0,  1 ],
  [  0,  1,  0,  0,  0,  0,  0 ],
  [  0,  1,  0,  0,  1,  1,  1 ],
  [  0,  1,  0,  1,  1,  0,  1 ],
  [  0,  1,  1,  0,  0,  1,  1 ],
  [  1,  0,  0,  0,  0,  0,  0 ],
  [  1,  0,  0,  0,  1,  1,  1 ],
  [  1,  0,  0,  1,  0,  1,  1 ],
  [  1,  0,  1,  0,  1,  0,  1 ],
  [  1,  1,  0,  1,  0,  0,  1 ],
  [  1,  1,  1,  0,  0,  0,  1 ] ]
gap> Display(NmzSupportHyperplanes(cone));
[ [   0,   0,   0,   0,   0,   0,   1 ],
  [   0,   0,   0,   0,   0,   1,   0 ],
  [   0,   0,   0,   0,   1,   0,   0 ],
  [   0,   0,   0,   1,   0,   0,   0 ],
  [   0,   0,   1,   0,   0,   0,   0 ],
  [   0,   0,   1,   1,   0,   1,  -1 ],
  [   0,   0,   1,   1,   1,   0,  -1 ],
  [   0,   1,   0,   0,   0,   0,   0 ],
  [   0,   1,   0,   0,   1,   1,  -1 ],
  [   0,   1,   0,   1,   1,   0,  -1 ],
  [   0,   1,   1,   0,   0,   1,  -1 ],
  [   0,   1,   1,   1,   1,   1,  -2 ],
  [   1,   0,   0,   0,   0,   0,   0 ],
  [   1,   0,   0,   0,   1,   1,  -1 ],
  [   1,   0,   0,   1,   0,   1,  -1 ],
  [   1,   0,   1,   0,   1,   0,  -1 ],
  [   1,   0,   1,   1,   1,   1,  -2 ],
  [   1,   1,   0,   1,   0,   0,  -1 ],
  [   1,   1,   0,   1,   1,   1,  -2 ],
  [   1,   1,   1,   0,   0,   0,  -1 ],
  [   1,   1,   1,   0,   1,   1,  -2 ],
  [   1,   1,   1,   1,   0,   1,  -2 ],
  [   1,   1,   1,   1,   1,   0,  -2 ],
  [   1,   1,   1,   1,   1,   1,  -3 ] ]
gap> Display(NmzHilbertBasis(cone));
[ [  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  1,  1,  0,  1,  1 ],
  [  0,  0,  1,  1,  1,  0,  1 ],
  [  0,  1,  0,  0,  0,  0,  0 ],
  [  0,  1,  0,  0,  1,  1,  1 ],
  [  0,  1,  0,  1,  1,  0,  1 ],
  [  0,  1,  1,  0,  0,  1,  1 ],
  [  1,  0,  0,  0,  0,  0,  0 ],
  [  1,  0,  0,  0,  1,  1,  1 ],
  [  1,  0,  0,  1,  0,  1,  1 ],
  [  1,  0,  1,  0,  1,  0,  1 ],
  [  1,  1,  0,  1,  0,  0,  1 ],
  [  1,  1,  1,  0,  0,  0,  1 ],
  [  1,  1,  1,  1,  1,  1,  2 ] ]
gap> Display(NmzDeg1Elements(cone));
[ [  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  1,  1,  0,  1,  1 ],
  [  0,  0,  1,  1,  1,  0,  1 ],
  [  0,  1,  0,  0,  0,  0,  0 ],
  [  0,  1,  0,  0,  1,  1,  1 ],
  [  0,  1,  0,  1,  1,  0,  1 ],
  [  0,  1,  1,  0,  0,  1,  1 ],
  [  1,  0,  0,  0,  0,  0,  0 ],
  [  1,  0,  0,  0,  1,  1,  1 ],
  [  1,  0,  0,  1,  0,  1,  1 ],
  [  1,  0,  1,  0,  1,  0,  1 ],
  [  1,  1,  0,  1,  0,  0,  1 ],
  [  1,  1,  1,  0,  0,  0,  1 ] ]
gap> Display(NmzSublattice(cone));
[ [ [ 1, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0 ],
      [ 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0 ], 
      [ 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 1 ] ], 
  [ [ 1, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0 ],
      [ 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0 ], 
      [ 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 1 ] ], 1 ]
gap> Display(NmzOriginalMonoidGenerators(cone));
[ [  1,  0,  0,  0,  0,  0,  0 ],
  [  0,  1,  0,  0,  0,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  0,  0,  1,  0 ],
  [  1,  1,  1,  0,  0,  0,  1 ],
  [  1,  1,  0,  1,  0,  0,  1 ],
  [  1,  0,  1,  0,  1,  0,  1 ],
  [  1,  0,  0,  1,  0,  1,  1 ],
  [  1,  0,  0,  0,  1,  1,  1 ],
  [  0,  1,  1,  0,  0,  1,  1 ],
  [  0,  1,  0,  1,  1,  0,  1 ],
  [  0,  1,  0,  0,  1,  1,  1 ],
  [  0,  0,  1,  1,  1,  0,  1 ],
  [  0,  0,  1,  1,  0,  1,  1 ] ]
gap> _NmzPrintSomeConeProperties(cone, [
> "Generators",
> "ExtremeRays",
> "SupportHyperplanes",
> "HilbertBasis",
> "Deg1Elements",
> "Sublattice",
> "NumberLatticePoints",
> "OriginalMonoidGenerators",
> ]);
BasicTriangulation = fail
ClassGroup = [ 17 ]
EhrhartQuasiPolynomial = [ [ 60, 194, 284, 245, 130, 41, 6 ], 60 ]
EmbeddingDim = 7
Grading = [ 1, 1, 1, 1, 1, 1, -2 ]
GradingDenom = 1
HilbertQuasiPolynomial = 
[ 1/10*t^6+41/60*t^5+13/6*t^4+49/12*t^3+71/15*t^2+97/30*t+1 ]
HilbertQuasiPolynomial = 
[ 1/10*t^6+41/60*t^5+13/6*t^4+49/12*t^3+71/15*t^2+97/30*t+1 ]
HilbertSeries = [ 6*t^4+25*t^3+31*t^2+9*t+1, [ [ 1, 7 ] ] ]
InternalIndex = 1
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = false
IsInhomogeneous = false
IsIntegrallyClosed = false
IsPointed = true
IsTriangulationNested = false
IsTriangulationPartial = false
MaximalSubspace = [  ]
Multiplicity = 72
Rank = 7
TriangulationDetSum = 72
TriangulationSize = 69
UnitGroupIndex = 1

#
gap> STOP_TEST("rproj2.tst", 0);
