#! @BeginChunk Demo_example
#! @BeginExample
C := NmzCone(["integral_closure",[[2,1],[1,3]]]);
#! <a Normaliz cone>
NmzHasConeProperty(C,"HilbertBasis");
#! false
NmzHasConeProperty(C,"SupportHyperplanes");
#! false
NmzConeProperty(C,"HilbertBasis");
#! [ [ 1, 1 ], [ 1, 2 ], [ 1, 3 ], [ 2, 1 ] ]
NmzHasConeProperty(C,"SupportHyperplanes");
#! true
NmzConeProperty(C,"SupportHyperplanes");
#! [ [ -1, 2 ], [ 3, -1 ] ]
#! @EndExample
#! @EndChunk


#! @BeginChunk Demo_example_equation
#! @BeginExample
D := NmzCone(["equations",[[1,2,-3]], "grading",[[0,-1,3]]]);
#! <a Normaliz cone>
NmzCompute(D,["DualMode","HilbertSeries"]);
#! true
NmzHilbertBasis(D);
#! [ [ 1, 1, 1 ], [ 0, 3, 2 ], [ 3, 0, 1 ] ]
NmzHilbertSeries(D);
#! [ t^2-t+1, [ [ 1, 1 ], [ 3, 1 ] ] ]
NmzHasConeProperty(D,"SupportHyperplanes");
#! true
NmzSupportHyperplanes(D);
#! [ [ 0, 1, 0 ], [ 1, 0, 0 ] ]
NmzEquations(D);
#! [ [ 1, 2, -3 ] ]
#! @EndExample
#! @EndChunk


#! @BeginChunk Demo_example_inhom_equation
#! @BeginExample
P := NmzCone(["inhom_equations",[[1,2,-3,1]], "grading", [[1,1,1]]]);
#! <a Normaliz cone>
NmzIsInhomogeneous(C);
#! false
NmzIsInhomogeneous(P);
#! true
NmzHilbertBasis(P);
#! [ [ 1, 1, 1, 0 ], [ 3, 0, 1, 0 ], [ 0, 3, 2, 0 ] ]
NmzModuleGenerators(P);
#! [ [ 0, 1, 1, 1 ], [ 2, 0, 1, 1 ] ]
#! @EndExample
#! @EndChunk

