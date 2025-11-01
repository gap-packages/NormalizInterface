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
gap> NmzConeProperty(cone, "BasicTriangulation");
fail
gap> NmzConeProperty(cone, "EmbeddingDim");
4
gap> NmzConeProperty(cone, "Grading");
[ 0, 1, 0, 0 ]
gap> NmzConeProperty(cone, "GradingDenom");
1
gap> NmzConeProperty(cone, "IsDeg1ExtremeRays");
true
gap> NmzConeProperty(cone, "IsDeg1HilbertBasis");
true
gap> NmzConeProperty(cone, "IsInhomogeneous");
false
gap> NmzConeProperty(cone, "IsPointed");
false
gap> NmzConeProperty(cone, "IsTriangulationNested");
false
gap> NmzConeProperty(cone, "IsTriangulationPartial");
true
gap> NmzConeProperty(cone, "MaximalSubspace");
[ [ 1, 0, 0, 0 ] ]
gap> NmzConeProperty(cone, "Multiplicity");
1
gap> NmzConeProperty(cone, "ProjectCone");
<a Normaliz cone>
gap> NmzConeProperty(cone, "Rank");
2
gap> NmzConeProperty(cone, "TriangulationDetSum");
0
gap> NmzConeProperty(cone, "TriangulationSize");
0

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
[ [ 0, 1, 0 ] ]
gap> Display(NmzSupportHyperplanes(proj));
[ [ 0, 1, 0 ] ]
gap> Display(NmzHilbertBasis(proj));
[ [ 0, 1, 0 ] ]
gap> Display(NmzDeg1Elements(proj));
[ [ 0, 1, 0 ] ]
gap> Display(NmzSublattice(proj));
[ [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], [ [ 1, 0 ], [ 0, 1 ], [ 0, 0 ] ], 1 ]
gap> NmzConeProperty(cone, "BasicTriangulation");
fail
gap> NmzConeProperty(cone, "EmbeddingDim");
3
gap> NmzConeProperty(cone, "Grading");
[ 0, 1, 0 ]
gap> NmzConeProperty(cone, "GradingDenom");
1
gap> NmzConeProperty(cone, "InternalIndex");
1
gap> NmzConeProperty(cone, "IsDeg1ExtremeRays");
true
gap> NmzConeProperty(cone, "IsDeg1HilbertBasis");
true
gap> NmzConeProperty(cone, "IsInhomogeneous");
false
gap> NmzConeProperty(cone, "IsIntegrallyClosed");
true
gap> NmzConeProperty(cone, "IsPointed");
false
gap> NmzConeProperty(cone, "IsTriangulationNested");
false
gap> NmzConeProperty(cone, "IsTriangulationPartial");
true
gap> NmzConeProperty(cone, "MaximalSubspace");
[ [ 1, 0, 0 ] ]
gap> NmzConeProperty(cone, "Multiplicity");
1
gap> NmzConeProperty(cone, "Rank");
2
gap> NmzConeProperty(cone, "TriangulationDetSum");
0
gap> NmzConeProperty(cone, "TriangulationSize");
0
gap> NmzConeProperty(cone, "UnitGroupIndex");
1

#
gap> STOP_TEST("project.tst", 0);
