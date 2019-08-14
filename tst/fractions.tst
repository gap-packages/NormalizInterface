gap> START_TEST("fractions.tst");

#
gap> M:=[[0, 0], [7/2, 0], [0, 9/4]];
[ [ 0, 0 ], [ 7/2, 0 ], [ 0, 9/4 ] ]
gap> cone := NmzCone(["polytope", M]);
<a Normaliz cone>
gap> NmzCompute(cone);
true
gap> NmzDeg1Elements(cone);
[ [ 0, 0, 1 ], [ 0, 1, 1 ], [ 0, 2, 1 ], [ 1, 0, 1 ], [ 1, 1, 1 ], 
  [ 2, 0, 1 ], [ 3, 0, 1 ] ]

#
gap> NmzVolume(cone);
63/8
gap> NmzEuclideanVolume(cone);
3.9375
gap> Display(NmzSupportHyperplanes(cone));
[ [  -18,  -28,   63 ],
  [    0,    1,    0 ],
  [    1,    0,    0 ] ]
gap> Display(NmzSuppHypsFloat(cone));
[ [   -0.2857142857142857,  -0.44444444444444442,                    1. ],
  [                    0.,                    1.,                    0. ],
  [                    1.,                    0.,                    0. ] ]

#
gap> STOP_TEST("fractions.tst", 0);
