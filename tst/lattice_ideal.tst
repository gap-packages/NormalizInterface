gap> START_TEST("NormalizInterface: lattice_ideal.tst");

#
gap> M := [
> [ 2, 1,  0, -1, -1,  -1 ],
> [ 1, 0, -1,  2, -1,  -1 ],
> [ 1, 1,  1,  0, -2,  -1 ],
> ];;
gap> cone := NmzCone(["lattice_ideal", M]);;
gap> NmzCompute(cone);
true
gap> NmzPrintConeProperties(cone);
Generators = 
[ [  0,  0,  1 ],
  [  0,  1,  0 ],
  [  1,  0,  3 ],
  [  1,  2,  1 ],
  [  1,  3,  0 ],
  [  3,  5,  2 ] ]
ExtremeRays = 
[ [  0,  0,  1 ],
  [  0,  1,  0 ],
  [  1,  0,  3 ],
  [  1,  3,  0 ],
  [  3,  5,  2 ] ]
SupportHyperplanes = 
[ [  -15,    7,    5 ],
  [   -3,    1,    2 ],
  [    0,    0,    1 ],
  [    0,    1,    0 ],
  [    1,    0,    0 ] ]
HilbertBasis = 
[ [  0,  0,  1 ],
  [  0,  1,  0 ],
  [  1,  0,  3 ],
  [  1,  1,  2 ],
  [  1,  2,  1 ],
  [  1,  3,  0 ],
  [  2,  3,  2 ],
  [  2,  4,  1 ],
  [  3,  5,  2 ] ]
Deg1Elements = 
[ [  0,  0,  1 ],
  [  0,  1,  0 ],
  [  1,  0,  3 ],
  [  1,  1,  2 ],
  [  1,  2,  1 ],
  [  1,  3,  0 ],
  [  2,  3,  2 ],
  [  2,  4,  1 ],
  [  3,  5,  2 ] ]
Sublattice = [ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 1 ]
OriginalMonoidGenerators = 
[ [  0,  0,  1 ],
  [  3,  5,  2 ],
  [  0,  1,  0 ],
  [  1,  2,  1 ],
  [  1,  3,  0 ],
  [  1,  0,  3 ] ]
MaximalSubspace = [  ]
Grading = [ -2, 1, 1 ]
TriangulationSize = 5
TriangulationDetSum = 10
GradingDenom = 1
UnitGroupIndex = 1
InternalIndex = 1
Multiplicity = 10
Rank = 3
EmbeddingDim = 3
IsPointed = true
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = true
IsIntegrallyClosed = false
IsInhomogeneous = false
ClassGroup = [ 2 ]
HilbertSeries = [ 3*t^2+6*t+1, [ [ 1, 3 ] ] ]
HilbertQuasiPolynomial = [ 5*t^2+3*t+1 ]
IsTriangulationNested = false
IsTriangulationPartial = false

#
gap> STOP_TEST("lattice_ideal.tst", 0);
