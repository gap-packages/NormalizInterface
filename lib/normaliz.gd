#! @Chapter Functions
#! @Section YOU FORGOT TO SET A SECTION

NormalizObjectFamily := NewFamily( "NormalizObjectFamily" );

DeclareCategory( "IsNormalizCone", IsObject );

BindGlobal("TheTypeNormalizCone", NewType( NormalizObjectFamily, IsNormalizCone ));


#
#! @Section Use a NmzCone
#

#! @Section Use a NmzCone
#! @Arguments TODO
#! @Returns TODO
#! @Description
#! TODO
DeclareGlobalFunction( "NmzCompute" );

#! @Arguments cone, property
#! @Returns TODO
#! @Description
#! TODO
DeclareGlobalFunction( "NmzConeProperty" );

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
#! The result record consists of Embedding A, Projection B, and Annihilator c.
#! They represent the mapping into the effective lattice  Z^r --> Z^n, v |-> vA
#! and the inverse operation Z^n --> Z^r, u |-> (uB)/c.
DeclareGlobalFunction( "NmzBasisChange" );


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
#! lattice_ideal, grading, excluded_faces, lattice, saturation, cone, offset,
#! vertices, support_hyperplanes, cone_and_lattice.
#!
#! See the Normaliz manual for a detailed description.
#!
#! @InsertChunk NmzCone example
DeclareGlobalFunction( "NmzCone" );
