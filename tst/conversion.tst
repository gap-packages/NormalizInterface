gap> START_TEST("NormalizInterface: conversion.tst");

## Check the multiplicity for some powers of 2:
gap> for n in [28,31,32,33,60,63,64,65] do
>   M := 2 * IdentityMat(n+1);;
>   C := NmzCone("polytope", M);;
>   mult := NmzMultiplicity(C);;  # should be 2^n
>   Print( mult, " equals 2^", n, "? ", 2^n = mult  , "\n" );
> od;
268435456 equals 2^28? true
2147483648 equals 2^31? true
4294967296 equals 2^32? true
8589934592 equals 2^33? true
1152921504606846976 equals 2^60? true
9223372036854775808 equals 2^63? true
18446744073709551616 equals 2^64? true
36893488147419103232 equals 2^65? true

## Check conversion for a matrix which entries contain
## e*2^n + d, where e is 1 or -1, d is -1, 0, 1, and n is, say, 28, 31,32, 60, 63, 64
gap> start := 25;;
gap> n := 40;; ## should be divisible by 4
gap> M := NullMat(n,2*n);;
gap> 
gap> for i in [1 .. n] do
>   M[i][n-i+1] := 1;  # antidiagonal element
>   entry := 2^(start+i) - n/4;
>   for j in [n+1 .. 2*n] do
>     M[i][j] := entry;
>     if j mod 2 <> 0 then
>       entry := -entry;
>     else
>       entry := -entry + 1;
>     fi;
>   od;
> od;
gap> 
gap> C := NmzCone("cone", M);
<a Normaliz cone>
gap> NmzMultiplicity(C);
1
gap> rays := NmzExtremeRays(C);;

#
gap> i := 1;;
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
26 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
27 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
28 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
29 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
30 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
31 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
32 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
33 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
34 true

#
gap> i := 58 - start;;
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
58 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
59 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
60 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
61 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
62 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
63 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
64 true
gap> Print(i+start," ", M[i] = rays[i], "\n"); i := i + 1;;
65 true

#
gap> STOP_TEST("conversion.tst", 0);
