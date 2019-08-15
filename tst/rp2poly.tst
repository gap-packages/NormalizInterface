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
ClassGroup = [ 16 ]
EmbeddingDim = 6
Grading = [ 1/3, 1/3, 1/3, 1/3, 1/3, 1/3 ]
GradingDenom = 3
HilbertQuasiPolynomial = [ 7/40*t^5+7/8*t^4+53/24*t^3+25/8*t^2+157/60*t+1 ]
HilbertSeries = [ t^4+4*t^3+11*t^2+4*t+1, [ [ 1, 6 ] ] ]
InternalIndex = 1
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = false
IsInhomogeneous = false
IsIntegrallyClosed = false
IsPointed = true
IsTriangulationNested = false
IsTriangulationPartial = false
MaximalSubspace = [  ]
Multiplicity = 21
Rank = 6
TriangulationDetSum = 21
TriangulationSize = 18
UnitGroupIndex = 1
gap> Display(NmzConeDecomposition(cone));
[ [ false, false, false, false, false, false ], 
  [ false, true, false, false, false, true ], 
  [ true, false, false, false, false, true ], 
  [ true, false, false, false, false, true ], 
  [ true, false, false, false, true, true ], 
  [ true, true, false, false, false, true ], 
  [ false, false, false, false, false, true ], 
  [ true, false, false, false, false, true ], 
  [ false, false, false, false, false, true ], 
  [ false, false, false, false, true, true ], 
  [ true, false, false, false, false, true ], 
  [ true, false, false, false, false, true ], 
  [ true, false, false, false, false, true ], 
  [ true, false, false, false, true, true ], 
  [ false, true, false, false, false, true ], 
  [ false, false, false, false, false, true ], 
  [ false, false, false, false, false, true ], 
  [ false, false, true, false, false, true ] ]
gap> ForAll(NmzConeDecomposition(cone), IsBlistRep);
true

#
gap> STOP_TEST("rp2poly.tst", 0);
