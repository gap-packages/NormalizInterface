gap> START_TEST("bugfix.tst");

#
# We used to incorrectly convert integer value "0" (zero) from type mpz_t
# to GAP integers, leading to bogus outputs in e.g. the following example.
# Fixed by adding a special case for zero to MpzToGAP.
#
gap> C := NmzCone(["integral_closure",[[1,2],[3,1]],"grading",[[1,1]]]);
<a Normaliz cone>
gap> _NmzConeProperty(C,"HilbertSeries");
[ [ 1, -1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1 ], [ 1, 12 ], 0 ]
gap> NmzHilbertSeries(C);
[ t^11+t^8+t^6+t^3+t^2-t+1, [ [ 1, 1 ], [ 12, 1 ] ] ]

#
# The following returns a bad result with Normaliz 3.4.0.
# See https://github.com/gap-packages/NormalizInterface/issues/58
#
gap> C := NmzCone( "integral_closure", [ [0,0,1], [0,2,1], [1,0,1], [1,1,1] ] );;
gap> NmzDeg1Elements(C);
[ [ 0, 0, 1 ], [ 0, 1, 1 ], [ 0, 2, 1 ], [ 1, 0, 1 ], [ 1, 1, 1 ] ]

#
# The following produces a segfault with Normaliz 3.4.0 and 3.5.1, but
# seems to work fine with 3.5.4 and newer.
# See https://github.com/gap-packages/NormalizInterface/issues/61
#
gap> L := [ [ -1, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, -1, -1, -1, 0 ],
>          [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ],  [ 1, 1, 0, 0, 0, 0 ],
>          [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 1, 1, 0 ], [ 0, 0, 1, 0, 0, 0 ],
>          [ 0, 0, 0, 1, 0, 0 ] ];;
gap> C := NmzCone( "inhom_inequalities", L );;
gap> NmzModuleGenerators(C);
[ [ 0, 0, 0, 0, 0, 1 ] ]

#
gap> STOP_TEST("bugfix.tst", 0);
