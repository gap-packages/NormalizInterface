NormalizObjectFamily := NewFamily( "NormalizObjectFamily" );

DeclareCategory( "IsNormalizCone", IsObject );

DeclareCategory( "IsNormalizLongIntCone", IsNormalizCone );
DeclareCategory( "IsNormalizGMPCone", IsNormalizCone );

BindGlobal("TheTypeNormalizLongIntCone", NewType( NormalizObjectFamily, IsNormalizLongIntCone ));
BindGlobal("TheTypeNormalizGMPCone", NewType( NormalizObjectFamily, IsNormalizGMPCone ));

DeclareOperation( "NmzConeProperty", [IsNormalizCone, IsString] );

#! @Arguments cone
#! @Returns a record describing the basis change
#! @Description
#! TODO
DeclareOperation( "NmzBasisChange", [IsNormalizCone] );

#! @Arguments cone[, options]
#! @Returns true if successful, otherwise false
#! @Description
#! TODO
DeclareGlobalFunction( "NmzCompute" );


#! @Section Create a NmzCone
#! @Description
#! Creates a NmzCone. The list argument should contain an even number of elements,
#! alternating between a string and a integer matrix. The string has to correspond
#! to a normaliz input type string and the following matrix will be interpreted as
#! input of that type.
#! Currently the following strings are recognized:
#! integral_closure, polyhedron, normalization, polytope, rees_algebra,
#! inequalities, strict_inequalities, signs, strict_signs, equations, congruences,
#! inhom_inequalities, inhom_equations, inhom_congruences, dehomogenization,
#! lattice_ideal, grading, excluded_faces.
#! See the Normaliz manual for a detailed description.
#! @Arguments list
#! @Returns NmzCone
DeclareGlobalFunction( "NmzCone" );
