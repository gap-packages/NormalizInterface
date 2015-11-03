#! @Chapter Functions
#! @Section YOU FORGOT TO SET A SECTION

NormalizObjectFamily := NewFamily( "NormalizObjectFamily" );

DeclareCategory( "IsNormalizCone", IsObject );

BindGlobal("TheTypeNormalizCone", NewType( NormalizObjectFamily, IsNormalizCone ));


#
#! @Section Use a NmzCone
#

#! @Section Use a NmzCone
#! @Arguments cone[, propnames]
#! @Returns a boolean indicating success
#! @Description
#! Start computing properties of the given cone.
#! The first parameter indicates a cone object, the second parameter
#! is either a single string, or a list of strings, which indicate
#! what should be computed
#!
#! The single parameter version is equivalent to
#! <C>NmzCone(cone, ["DefaultMode"])</C>.
#! @InsertChunk NmzCompute example
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
#! The result record <C>r</C> has three components:
#! <C>r.Embedding</C>, <C>r.Projection</C>, and <C>r.Annihilator</C>,
#! where the embedding <C>A</C> and the projection <C>B</C>
#! are matrices, and the annihilator <C>c</C> is an integer.
#! They represent the mapping into the effective lattice
#! <M>Z^r \to Z^n, v \mapsto vA</M>
#! and the inverse operation <M>Z^n \to Z^r, u \mapsto (uB)/c</M>.
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
#! <List>
#! <Item><C>integral_closure</C>,</Item>
#! <Item><C>polyhedron</C>,</Item>
#! <Item><C>normalization</C>,</Item>
#! <Item><C>polytope</C>,</Item>
#! <Item><C>rees_algebra</C>,</Item>
#! <Item><C>inequalities</C>,</Item>
#! <Item><C>strict_inequalities</C>,</Item>
#! <Item><C>signs</C>,</Item>
#! <Item><C>strict_signs</C>,</Item>
#! <Item><C>equations</C>,</Item>
#! <Item><C>congruences</C>,</Item>
#! <Item><C>inhom_inequalities</C>,</Item>
#! <Item><C>inhom_equations</C>,</Item>
#! <Item><C>inhom_congruences</C>,</Item>
#! <Item><C>dehomogenization</C>,</Item>
#! <Item><C>lattice_ideal</C>,</Item>
#! <Item><C>grading</C>,</Item>
#! <Item><C>excluded_faces</C>,</Item>
#! <Item><C>lattice</C>,</Item>
#! <Item><C>saturation</C>,</Item>
#! <Item><C>cone</C>,</Item>
#! <Item><C>offset</C>,</Item>
#! <Item><C>vertices</C>,</Item>
#! <Item><C>support_hyperplanes</C>,</Item>
#! <Item><C>cone_and_lattice</C>.</Item>
#! </List>
#!
#! See the Normaliz manual for a detailed description.
#!
#! @InsertChunk NmzCone example
DeclareGlobalFunction( "NmzCone" );
