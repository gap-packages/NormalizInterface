#! @BeginChunk NmzCone example
#! @BeginExample
cone := NmzCone(["integral_closure",[[2,1],[1,3]]]);
#! <a Normaliz cone with long int coefficients>
#! @EndExample
#! @EndChunk

#! @BeginChunk NmzCone GMP example
#! @BeginExample
cone := NmzCone(["integral_closure",[[2,1],[1,3]]] : gmp);
#! <a Normaliz cone with GMP coefficients>
#! @EndExample
#! @EndChunk

