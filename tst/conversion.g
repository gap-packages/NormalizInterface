## Check the multiplicity for some powers of 2:
for n in [28,31,32,33,60,63,64,65] do
  M := 2 * IdentityMat(n+1);;
  C := NmzCone("polytope", M);;
  mult := NmzMultiplicity(C);;  # should be 2^n
  Print( mult, " equals 2^n? ", 2^n = mult  , "\n" );
od;


## Check conversion for a matrix which entries contain
## e*2^n + d, where e is 1 or -1, d is -1, 0, 1, and n is, say, 28, 31,32, 60, 63, 64

start := 25;;
n := 40;; ## should be divisible by 4
M := NullMat(n,2*n);;

for i in [1 .. n] do
  M[i][n-i+1] := 1;  # antidiagonal element
  entry := 2^(start+i) - n/4;
  for j in [n+1 .. 2*n] do
    M[i][j] := entry;
    if j mod 2 <> 0 then
      entry := -entry;
    else
      entry := -entry + 1;
    fi;
  od;
od;

C := NmzCone("cone", M);
NmzMultiplicity(C);
Rays := NmzExtremeRays(C);

## M and Rays should be the same!

for i in [1..40] do 
  Print(i+start," ", M[i] = Rays[i], "\n");
  if M[i] <> Rays[i] then
    Print(M[i],"\n");
    Print(Rays[i],"\n");
  fi;
od;
