#! @Chapter Functions
#! @Section YOU FORGOT TO SET A SECTION

NormalizObjectFamily := NewFamily( "NormalizObjectFamily" );

DeclareCategory( "IsNormalizCone", IsObject );

DeclareCategory( "IsNormalizLongIntCone", IsNormalizCone );
DeclareCategory( "IsNormalizGMPCone", IsNormalizCone );

BindGlobal("TheTypeNormalizLongIntCone", NewType( NormalizObjectFamily, IsNormalizLongIntCone ));
BindGlobal("TheTypeNormalizGMPCone", NewType( NormalizObjectFamily, IsNormalizGMPCone ));


#
#! @Section Use a NmzCone
#

#! @Section Use a NmzCone
#! @Arguments cone[, options]
#! @Returns true if successful, otherwise false
#! @Description
#! TODO
DeclareGlobalFunction( "NmzCompute" );

#! @Arguments cone, property
#! @Returns true if successful, otherwise false
#! @Description
#! TODO
DeclareOperation( "NmzConeProperty", [IsNormalizCone, IsString] );

#! @Arguments cone
#! @Description
#! Print an overview of all known properties of the given cone,
#! as well as their values.
DeclareGlobalFunction( "NmzPrintConeProperties" );

#
#! @Section Cone properties
#

#! @Arguments cone
#! @Returns a record describing the basis change
#! @Description
#! TODO
DeclareOperation( "NmzBasisChange", [IsNormalizCone] );


#! @Section Create a NmzCone
#! @Arguments list
#! @Returns NmzCone
#! @Description
#! Creates a NmzCone. The <A>list</A> argument should contain an even number of
#! elements, alternating between a string and a integer matrix. The string has to
#! correspond to a normaliz input type string and the following matrix will be
#! interpreted as input of that type.
#!
#! Currently the following strings are recognized:
#! integral_closure, polyhedron, normalization, polytope, rees_algebra,
#! inequalities, strict_inequalities, signs, strict_signs, equations, congruences,
#! inhom_inequalities, inhom_equations, inhom_congruences, dehomogenization,
#! lattice_ideal, grading, excluded_faces.
#!
#! See the Normaliz manual for a detailed description.
#!
#! @InsertChunk NmzCone example
#!
#! It is also possible to create a cone object using multi-precision GMP
#! integers, which results in slower computations but allows handling some
#! examples that are not supported with machine integers. To do this,
#! specify the <C>gmp</C> option as in the following example.
#! @InsertChunk NmzCone GMP example
DeclareGlobalFunction( "NmzCone" );
