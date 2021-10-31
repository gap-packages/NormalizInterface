gap> START_TEST("project.tst");

#
gap> # Based on nonpointed.in
gap> cone := NmzCone([
> "equations", [[0, 0, 1, 0], [0, 0, 0, 1]],
> "inequalities", [[0, 1, 0, 0]],
> "projection_coordinates", [[1, 1, 1, 0]]]);;
gap> proj:=NmzProjectCone(cone);
<a Normaliz cone>

# check what was computed for the input cone
gap> tmp := NmzKnownConeProperties(cone);;
gap> RemoveSet(tmp, "NumberLatticePoints");
gap> Perform(tmp, Display);
EmbeddingDim
ExtremeRays
Generators
IsInhomogeneous
IsPointed
MaximalSubspace
ProjectCone
Rank
Sublattice
SupportHyperplanes
gap> Display(NmzTriangulation(cone));
[ [ rec(
          Excluded := [  ],
          height := 0,
          key := [ 0 ],
          mult := 0,
          vol := 1 ) ], [ [ 0, 1, 0, 0 ] ] ]
gap> Display(NmzExtremeRays(cone));
[ [  0,  1,  0,  0 ] ]
gap> Display(NmzSupportHyperplanes(cone));
[ [  0,  1,  0,  0 ] ]
gap> Display(NmzHilbertBasis(cone));
[ [  0,  1,  0,  0 ] ]
gap> Display(NmzDeg1Elements(cone));
[ [  0,  1,  0,  0 ] ]
gap> Display(NmzSublattice(cone));
[ [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ] ], 
  [ [ 1, 0 ], [ 0, 1 ], [ 0, 0 ], [ 0, 0 ] ], 1 ]
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
EmbeddingDim = 4
Grading = [ 0, 1, 0, 0 ]
GradingDenom = 1
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = true
IsInhomogeneous = false
IsPointed = false
IsTriangulationNested = false
IsTriangulationPartial = true
MaximalSubspace = 
[ [  1,  0,  0,  0 ] ]
Multiplicity = 1
ProjectCone = <object>
Rank = 2
TriangulationDetSum = 0
TriangulationSize = 0

# check what was computed for the projected cone
gap> Perform(NmzKnownConeProperties(proj), Display);
EmbeddingDim
ExtremeRays
Generators
Grading
GradingDenom
InternalIndex
IsDeg1ExtremeRays
IsInhomogeneous
IsPointed
MaximalSubspace
OriginalMonoidGenerators
Rank
Sublattice
SupportHyperplanes
gap> Display(NmzTriangulation(proj));
[ [ rec(
          Excluded := [  ],
          height := 0,
          key := [ 0 ],
          mult := 0,
          vol := 1 ) ], [ [ 0, 1, 0 ] ] ]
gap> Display(NmzExtremeRays(proj));
[ [  0,  1,  0 ] ]
gap> Display(NmzSupportHyperplanes(proj));
[ [  0,  1,  0 ] ]
gap> Display(NmzHilbertBasis(proj));
[ [  0,  1,  0 ] ]
gap> Display(NmzDeg1Elements(proj));
[ [  0,  1,  0 ] ]
gap> Display(NmzSublattice(proj));
[ [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], [ [ 1, 0 ], [ 0, 1 ], [ 0, 0 ] ], 1 ]
gap> _NmzPrintSomeConeProperties(proj, [
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
EmbeddingDim = 3
Grading = [ 0, 1, 0 ]
GradingDenom = 1
InternalIndex = 1
IsDeg1ExtremeRays = true
IsDeg1HilbertBasis = true
IsInhomogeneous = false
IsIntegrallyClosed = true
IsPointed = false
IsTriangulationNested = false
IsTriangulationPartial = true
MaximalSubspace = 
[ [  1,  0,  0 ] ]
Multiplicity = 1
Rank = 2
TriangulationDetSum = 0
TriangulationSize = 0
UnitGroupIndex = 1

#
gap> STOP_TEST("project.tst", 0);
