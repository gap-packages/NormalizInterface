gap> START_TEST("rees.tst");

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
gap> cone := NmzCone(["rees_algebra", M]);;
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
InternalIndex
IsDeg1ExtremeRays
IsDeg1HilbertBasis
IsInhomogeneous
IsIntegrallyClosed
IsPointed
IsReesPrimary
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
ClassGroup = [ 17 ]
EmbeddingDim = 7
Grading = [ 1, 1, 1, 1, 1, 1, -2 ]
GradingDenom = 1
HilbertQuasiPolynomial = 
[ 1/10*t^6+41/60*t^5+13/6*t^4+49/12*t^3+71/15*t^2+97/30*t+1 ]
HilbertSeries = [ 6*t^4+25*t^3+31*t^2+9*t+1, [ [ 1, 7 ] ] ]
InternalIndex = 1
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = false
IsInhomogeneous = false
IsIntegrallyClosed = false
IsPointed = true
IsReesPrimary = false
IsTriangulationNested = false
IsTriangulationPartial = false
MaximalSubspace = [  ]
Multiplicity = 72
Rank = 7
TriangulationDetSum = 72
TriangulationSize = 69
UnitGroupIndex = 1

#
gap> STOP_TEST("rees.tst", 0);
