#
# We used to incorrectly convert integer value "0" (zero) from type mpz_t
# to GAP integers, leading to bogus outputs in e.g. the following example.
# Fixed by adding a special case for zero to MpzToGAP.
#
gap> C := NmzCone(["integral_closure",[[1,2],[3,1]],"grading",[[1,1]]]);
<a Normaliz cone with long int coefficients>
gap> _NmzConeProperty(C,"HilbertSeries");
[ [ 1, -1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1 ], [ 1, 12 ] ]
gap> NmzHilbertSeries(C);
[ t^11+t^8+t^6+t^3+t^2-t+1, [ [ 1, 1 ], [ 12, 1 ] ] ]