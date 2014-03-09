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
gap> 
gap> C := NmzCone(["integral_closure", M, "grading", gr]);
<a Normaliz cone object>
gap> NmzHasConeProperty(C, "HilbertBasis");
false
gap> NmzConeProperty(C, "HilbertBasis");
[ [ 1, 2, 1 ], [ 1, 3, 1 ] ]
gap> NmzHilbertBasis(C);
[ [ 1, 2, 1 ], [ 1, 3, 1 ] ]
