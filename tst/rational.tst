gap> START_TEST("rational.tst");

#
gap> M := [
> [  1,  1,  2 ],
> [ -1, -1,  3 ],
> [  1, -2,  4 ],
> ];;
gap> gr := [ [ 0, 0, 1 ] ];;
gap> cone := NmzCone(["integral_closure", M, "grading", gr]);;
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
[ [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   1,  -2,   4 ] ]
gap> Display(NmzExtremeRays(cone));
[ [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   1,  -2,   4 ] ]
gap> Display(NmzSupportHyperplanes(cone));
[ [  -8,   2,   3 ],
  [   1,  -1,   0 ],
  [   2,   7,   3 ] ]
gap> Display(NmzHilbertBasis(cone));
[ [   0,   0,   1 ],
  [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   0,  -1,   3 ],
  [   1,   0,   3 ],
  [   1,  -2,   4 ],
  [   1,  -1,   4 ],
  [   0,  -2,   5 ] ]
gap> Display(NmzDeg1Elements(cone));
[ [  0,  0,  1 ] ]
gap> Display(NmzSublattice(cone));
[ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 1 ]
gap> Display(NmzOriginalMonoidGenerators(cone));
[ [   1,   1,   2 ],
  [  -1,  -1,   3 ],
  [   1,  -2,   4 ] ]
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
ClassGroup = [ 0, 3, 15 ]
EmbeddingDim = 3
Grading = [ 0, 0, 1 ]
GradingDenom = 1
HilbertQuasiPolynomial = [ 5/16*t^2+7/12*t+1, 5/16*t^2+11/24*t+11/48, 
  5/16*t^2+7/12*t-5/12, 5/16*t^2+11/24*t+13/16, 5/16*t^2+7/12*t+2/3, 
  5/16*t^2+11/24*t-5/48, 5/16*t^2+7/12*t+1/4, 5/16*t^2+11/24*t+23/48, 
  5/16*t^2+7/12*t+1/3, 5/16*t^2+11/24*t+9/16, 5/16*t^2+7/12*t-1/12, 
  5/16*t^2+11/24*t+7/48 ]
HilbertSeries = [ 2*t^12+t^11+t^10+t^9+t^8+2*t^7+2*t^6-t^5+2*t^4+3*t^3+1, 
  [ [ 1, 1 ], [ 2, 1 ], [ 12, 1 ] ] ]
InternalIndex = 15
IsDeg1ExtremeRays = false
IsDeg1HilbertBasis = false
IsInhomogeneous = false
IsIntegrallyClosed = false
IsPointed = true
IsTriangulationNested = false
IsTriangulationPartial = false
MaximalSubspace = [  ]
Multiplicity = 5/8
Rank = 3
TriangulationDetSum = 15
TriangulationSize = 1
UnitGroupIndex = 1
gap> Display(NmzConeDecomposition(cone));
[ [ false, false, false ] ]
gap> ForAll(NmzConeDecomposition(cone), IsBlistRep);
true

#
gap> NmzStanleyDec(cone);
[ [ [ 0, 1, 2 ], 
      [ [ 0, 0, 0 ], [ 3, 3, 0 ], [ 6, 6, 0 ], [ 9, 9, 0 ], [ 12, 12, 0 ], 
          [ 7, 2, 10 ], [ 10, 5, 10 ], [ 13, 8, 10 ], [ 1, 11, 10 ], 
          [ 4, 14, 10 ], [ 14, 4, 5 ], [ 2, 7, 5 ], [ 5, 10, 5 ], 
          [ 8, 13, 5 ], [ 11, 1, 5 ] ] ] ]

#
gap> (_NmzVersion() < [3, 7, 0]) or (NmzFVector(cone) = [ 1, 3, 3, 1 ]);
true
gap> (_NmzVersion() < [3, 7, 0]) or (NmzFaceLattice(cone) =
> [ [ [ false, false, false ], 0 ], [ [ true, false, false ], 1 ], 
>   [ [ false, true, false ], 1 ], [ [ true, true, false ], 2 ], 
>   [ [ false, false, true ], 1 ], [ [ true, false, true ], 2 ], 
>   [ [ false, true, true ], 2 ], [ [ true, true, true ], 3 ] ]);
true

#
gap> STOP_TEST("rational.tst", 0);
