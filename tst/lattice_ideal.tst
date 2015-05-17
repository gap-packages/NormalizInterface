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
  [  1,  1,  1 ],
  [  1,  2,  0 ],
  [  2,  0,  3 ],
  [  3,  3,  1 ] ]
ExtremeRays = 
[ [  0,  0,  1 ],
  [  0,  1,  0 ],
  [  1,  2,  0 ],
  [  2,  0,  3 ],
  [  3,  3,  1 ] ]
SupportHyperplanes = 
[ [  -9,   7,   6 ],
  [  -2,   1,   3 ],
  [   0,   0,   1 ],
  [   0,   1,   0 ],
  [   1,   0,   0 ] ]
TriangulationSize = 5
TriangulationDetSum = 10
Multiplicity = 10
HilbertBasis = 
[ [  0,  0,  1 ],
  [  0,  1,  0 ],
  [  1,  0,  2 ],
  [  1,  1,  1 ],
  [  1,  2,  0 ],
  [  2,  0,  3 ],
  [  2,  1,  2 ],
  [  2,  2,  1 ],
  [  3,  3,  1 ] ]
Deg1Elements = 
[ [  0,  0,  1 ],
  [  0,  1,  0 ],
  [  1,  0,  2 ],
  [  1,  1,  1 ],
  [  1,  2,  0 ],
  [  2,  0,  3 ],
  [  2,  1,  2 ],
  [  2,  2,  1 ],
  [  3,  3,  1 ] ]
HilbertSeries = [ 3*t^2+6*t+1, [ [ 1, 3 ] ] ]
HilbertFunction = [ 5*t^2+3*t+1 ]
Grading = [ -1, 1, 1 ]
IsPointed = true
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = true
IsIntegrallyClosed = false
OriginalMonoidGenerators = 
[ [  1,  2,  0 ],
  [  2,  0,  3 ],
  [  0,  1,  0 ],
  [  1,  1,  1 ],
  [  0,  0,  1 ],
  [  3,  3,  1 ] ]
GeneratorsOfToricRing = 
[ [  1,  2,  0 ],
  [  2,  0,  3 ],
  [  0,  1,  0 ],
  [  1,  1,  1 ],
  [  0,  0,  1 ],
  [  3,  3,  1 ] ]
DefaultMode = true
ClassGroup = [ 2 ]
