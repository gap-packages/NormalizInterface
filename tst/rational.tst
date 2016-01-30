gap> M := [
> [  1,  1,  2 ],
> [ -1, -1,  3 ],
> [  1, -2,  4 ],
> ];;
gap> gr := [ [ 0, 0, 1 ] ];;
gap> cone := NmzCone(["integral_closure", M, "grading", gr]);;
gap> NmzCompute(cone);
true
gap> NmzPrintConeProperties(cone);
Generators = 
[ [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   1,  -2,   4 ] ]
ExtremeRays = 
[ [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   1,  -2,   4 ] ]
SupportHyperplanes = 
[ [  -8,   2,   3 ],
  [   1,  -1,   0 ],
  [   2,   7,   3 ] ]
TriangulationSize = 1
TriangulationDetSum = 15
Multiplicity = 5/8
HilbertBasis = 
[ [   0,   0,   1 ],
  [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   0,  -1,   3 ],
  [   1,   0,   3 ],
  [   1,  -2,   4 ],
  [   1,  -1,   4 ],
  [   0,  -2,   5 ] ]
Deg1Elements = 
[ [  0,  0,  1 ] ]
HilbertSeries = [ 2*t^12+t^11+t^10+t^9+t^8+2*t^7+2*t^6-t^5+2*t^4+3*t^3+1, 
  [ [ 1, 1 ], [ 2, 1 ], [ 12, 1 ] ] ]
HilbertQuasiPolynomial = [ 5/16*t^2+7/12*t+1, 5/16*t^2+11/24*t+11/48, 
  5/16*t^2+7/12*t-5/12, 5/16*t^2+11/24*t+13/16, 5/16*t^2+7/12*t+2/3, 
  5/16*t^2+11/24*t-5/48, 5/16*t^2+7/12*t+1/4, 5/16*t^2+11/24*t+23/48, 
  5/16*t^2+7/12*t+1/3, 5/16*t^2+11/24*t+9/16, 5/16*t^2+7/12*t-1/12, 
  5/16*t^2+11/24*t+7/48 ]
Grading = [ 0, 0, 1 ]
IsPointed = true
IsDeg1ExtremeRays = false
IsDeg1HilbertBasis = false
IsIntegrallyClosed = false
OriginalMonoidGenerators = 
[ [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   1,  -2,   4 ] ]
Sublattice = true
ClassGroup = [ 0, 3, 15 ]
MaximalSubspace = [ ]
