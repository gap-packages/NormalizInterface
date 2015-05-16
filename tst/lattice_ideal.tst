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
[ [  0,  1,  2 ],
  [  3,  2,  0 ],
  [  0,  0,  1 ],
  [  1,  1,  1 ],
  [  1,  0,  0 ],
  [  1,  3,  3 ] ]
ExtremeRays = 
[ [  0,  1,  2 ],
  [  3,  2,  0 ],
  [  0,  0,  1 ],
  [  1,  0,  0 ],
  [  1,  3,  3 ] ]
SupportHyperplanes = 
[ [   1,   0,   0 ],
  [   0,   1,   0 ],
  [   0,   0,   1 ],
  [   3,  -2,   1 ],
  [   6,  -9,   7 ] ]
TriangulationSize = 3
TriangulationDetSum = 10
Multiplicity = 10
HilbertBasis = 
[ [  0,  1,  2 ],
  [  3,  2,  0 ],
  [  0,  0,  1 ],
  [  1,  0,  0 ],
  [  1,  3,  3 ],
  [  1,  1,  1 ],
  [  2,  1,  0 ],
  [  1,  2,  2 ],
  [  2,  2,  1 ] ]
Deg1Elements = 
[ [  0,  1,  2 ],
  [  3,  2,  0 ],
  [  0,  0,  1 ],
  [  1,  0,  0 ],
  [  1,  3,  3 ],
  [  1,  1,  1 ],
  [  2,  1,  0 ],
  [  1,  2,  2 ],
  [  2,  2,  1 ] ]
HilbertSeries = [ 3*t^2+6*t+1, [ [ 1, 3 ] ] ]
HilbertFunction = [ 5*t^2+3*t+1 ]
Grading = [ 1, -1, 1 ]
IsPointed = true
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = true
IsIntegrallyClosed = false
OriginalMonoidGenerators = 
[ [  0,  1,  2 ],
  [  3,  2,  0 ],
  [  0,  0,  1 ],
  [  1,  1,  1 ],
  [  1,  0,  0 ],
  [  1,  3,  3 ] ]
GeneratorsOfToricRing = 
[ [  0,  1,  2 ],
  [  3,  2,  0 ],
  [  0,  0,  1 ],
  [  1,  1,  1 ],
  [  1,  0,  0 ],
  [  1,  3,  3 ] ]
DefaultMode = true
