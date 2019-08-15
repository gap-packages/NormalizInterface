gap> START_TEST("lattice_ideal.tst");

#
gap> M := [
> [ 2, 1,  0, -1, -1,  -1 ],
> [ 1, 0, -1,  2, -1,  -1 ],
> [ 1, 1,  1,  0, -2,  -1 ],
> ];;
gap> cone := NmzCone(["lattice_ideal", M]);;
gap> NmzCompute(cone);
true
gap> Display(NmzGenerators(cone));
[ [  0,  0,  1 ],
  [  0,  1,  3 ],
  [  1,  0,  0 ],
  [  1,  1,  2 ],
  [  2,  3,  5 ],
  [  3,  1,  0 ] ]
gap> Display(NmzExtremeRays(cone));
[ [  0,  0,  1 ],
  [  0,  1,  3 ],
  [  1,  0,  0 ],
  [  2,  3,  5 ],
  [  3,  1,  0 ] ]
gap> Display(NmzSupportHyperplanes(cone));
[ [    0,    0,    1 ],
  [    0,    1,    0 ],
  [    1,    0,    0 ],
  [    2,   -3,    1 ],
  [    5,  -15,    7 ] ]
gap> Display(NmzHilbertBasis(cone));
[ [  0,  0,  1 ],
  [  0,  1,  3 ],
  [  1,  0,  0 ],
  [  1,  1,  2 ],
  [  1,  2,  4 ],
  [  2,  1,  1 ],
  [  2,  2,  3 ],
  [  2,  3,  5 ],
  [  3,  1,  0 ] ]
gap> Display(NmzDeg1Elements(cone));
[ [  0,  0,  1 ],
  [  0,  1,  3 ],
  [  1,  0,  0 ],
  [  1,  1,  2 ],
  [  1,  2,  4 ],
  [  2,  1,  1 ],
  [  2,  2,  3 ],
  [  2,  3,  5 ],
  [  3,  1,  0 ] ]
gap> Display(NmzSublattice(cone));
[ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 1 ]
gap> Display(NmzOriginalMonoidGenerators(cone));
[ [  1,  0,  0 ],
  [  2,  3,  5 ],
  [  0,  0,  1 ],
  [  1,  1,  2 ],
  [  0,  1,  3 ],
  [  3,  1,  0 ] ]
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
ClassGroup = [ 2 ]
EmbeddingDim = 3
Grading = [ 1, -2, 1 ]
GradingDenom = 1
HilbertQuasiPolynomial = [ 5*t^2+3*t+1 ]
HilbertSeries = [ 3*t^2+6*t+1, [ [ 1, 3 ] ] ]
InternalIndex = 1
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = true
IsInhomogeneous = false
IsIntegrallyClosed = false
IsPointed = true
IsTriangulationNested = false
IsTriangulationPartial = false
MaximalSubspace = [  ]
Multiplicity = 10
Rank = 3
TriangulationDetSum = 10
TriangulationSize = 5
UnitGroupIndex = 1
gap> Display(NmzConeDecomposition(cone));
[ [ false, false, false ], [ false, false, true ], [ false, false, true ], 
  [ true, false, true ], [ false, false, true ] ]
gap> ForAll(NmzConeDecomposition(cone), IsBlistRep);
true

#
gap> STOP_TEST("lattice_ideal.tst", 0);
