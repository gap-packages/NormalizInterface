M := [
[0,  2,  1],
[0, -2,  3],
[2, -2,  3]
];

InhomIneq := NmzCone(["inhom_inequalities", M, "grading", [[1,0]] ]);
NmzHilbertSeries(InhomIneq);

