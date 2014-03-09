gap> M := [[1,2,1],[1,3,1]];
[ [ 1, 2, 1 ], [ 1, 3, 1 ] ]
gap> gr := [[1,1,1]];
[ [ 1, 1, 1 ] ]
gap> C := NmzCone(["integral_closure", M, "grading", gr]);
<a Normaliz cone object>
gap> NmzHilbertBasis(C);
[ [ 1, 2, 1 ], [ 1, 3, 1 ] ]
gap> NmzCongruences(C);
[  ]
gap> NmzSupportHyperplanes(C);
[ [ 3, -1, 0 ], [ -2, 1, 0 ] ]
gap> NmzDeg1Elements(C);
[  ]
gap> NmzConeProperty(C, "Multiplicity");
1/20
gap> 
gap> #############################################
gap> 
gap> C := NmzCone(["integral_closure", M, "grading", gr]);
<a Normaliz cone object>
gap> NmzHasConeProperty(C, "HilbertBasis");
false
gap> NmzConeProperty(C, "HilbertBasis");
[ [ 1, 2, 1 ], [ 1, 3, 1 ] ]
gap> NmzHilbertBasis(C);
[ [ 1, 2, 1 ], [ 1, 3, 1 ] ]
gap> 
gap> #############################################
gap> 
gap> M:=[[2, 0, 0],
> [1, 3, 1],
> [3, 3, 1],
> [0, 0, 2],
> [1,-3, 1]];;
gap> cone:=NmzCone(["polytope",M]);
<a Normaliz cone object>
gap> NmzHilbertBasis(cone);
[ [ 0, 0, 2, 1 ], [ 1, -3, 1, 1 ], [ 1, -2, 1, 1 ],
  [ 1, -1, 1, 1 ], [ 1, 0, 1, 1 ], [ 1, 1, 1, 1 ],
  [ 1, 2, 1, 1 ], [ 1, 3, 1, 1 ], [ 2, 0, 0, 1 ],
  [ 2, 0, 1, 1 ], [ 2, 1, 1, 1 ], [ 2, 2, 1, 1 ],
  [ 2, 3, 1, 1 ], [ 3, 3, 1, 1 ] ]
gap> cone:=NmzCone(["integral_closure", M]);
<a Normaliz cone object>
gap> NmzHilbertBasis(cone);
[ [ 0, 0, 1 ], [ 1, -3, 1 ], [ 1, -2, 1 ],
  [ 1, -1, 1 ], [ 1, 0, 0 ], [ 1, 1, 1 ],
  [ 1, 2, 1 ], [ 1, 3, 1 ] ]
