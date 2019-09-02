#! @BeginChunk example_dual
#! @BeginExample
M := [
 [ 8,  8,  8,  7 ],
 [ 0,  4,  0,  1 ],
 [ 0,  1,  0,  7 ],
 [ 0, -2,  0,  7 ],
 [ 0, -2,  0,  1 ],
 [ 8, 48,  8, 17 ],
 [ 1,  6,  1, 34 ],
 [ 2,-12, -2, 37 ],
 [ 4,-24, -4, 14 ]
];;
D := NmzCone(["inhom_inequalities", M,
              "signs", [[1,1,1]],
              "grading", [[1,1,1]]]);
#! <a Normaliz cone>
NmzCompute(D,["DualMode","HilbertBasis","ModuleGenerators"]);
#! true
NmzHilbertBasis(D);
#! [ [ 1, 0, 0, 0 ], [ 1, 0, 1, 0 ] ]
NmzModuleGenerators(D);
#! [ [ 0, 0, 0, 1 ], [ 0, 0, 1, 1 ], [ 0, 0, 2, 1 ], [ 0, 0, 3, 1 ] ]
#! @EndExample
#! @EndChunk

