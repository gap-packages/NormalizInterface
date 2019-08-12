gap> START_TEST("verticesfloat.tst");
gap> M := [
> [  1,  1,  2 ],
> [ -1, -1,  3 ],
> [  1, -2,  4 ],
> ];;
gap> gr := [ [ 0, 0, 1 ] ];;
gap> cone := NmzCone(["integral_closure", M, "grading", gr]);;
gap> NmzVerticesFloat(cone);
[ [ 0.5, 0.5, 1. ], [ -0.333333, -0.333333, 1. ], [ 0.25, -0.5, 1. ] ]
gap> STOP_TEST("verticesfloat.tst", 0);
