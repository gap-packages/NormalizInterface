gap> START_TEST("dual.tst");

#
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
gap> cone := NmzCone(["inequalities", M]);;
gap> NmzCompute(cone);
true
gap> tmp := Set(NmzKnownConeProperties(cone));;
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
IsDeg1ExtremeRays
IsDeg1HilbertBasis
IsInhomogeneous
IsPointed
IsTriangulationNested
IsTriangulationPartial
MaximalSubspace
Multiplicity
Rank
Sublattice
SupportHyperplanes
TriangulationDetSum
TriangulationSize
gap> Display(NmzGenerators(cone));
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
ClassGroup = [ 17 ]
EmbeddingDim = 7
Grading = [ 1, 1, 1, 1, 1, 1, -2 ]
GradingDenom = 1
HilbertQuasiPolynomial = 
[ 1/10*t^6+41/60*t^5+13/6*t^4+49/12*t^3+71/15*t^2+97/30*t+1 ]
HilbertSeries = [ 6*t^4+25*t^3+31*t^2+9*t+1, [ [ 1, 7 ] ] ]
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = false
IsInhomogeneous = false
IsPointed = true
IsTriangulationNested = false
IsTriangulationPartial = false
MaximalSubspace = [  ]
Multiplicity = 72
Rank = 7
TriangulationDetSum = 72
TriangulationSize = 69

#
gap> STOP_TEST("dual.tst", 0);
