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
#! what should be computed.
#! <P/>
#!
#! The single parameter version is equivalent to
#! <C>NmzCone(cone, ["DefaultMode"])</C>.
#! See <Ref Func="NmzConeProperty"/> for a list of recognized properties.
#! @InsertChunk NmzCompute_example
DeclareGlobalFunction( "NmzCompute" );

#! @Arguments cone, property
#! @Returns the result of the computation, type depends on the property
#! @Description
#! Triggers the computation of the property of the cone and returns the result.
#! If the property was already known, it is not recomputed.
#! Currently the following strings are recognized as properties:
#! <List>
#! <Item><C>Generators</C> see <Ref Func="NmzGenerators"/>,</Item>
#! <Item><C>ExtremeRays</C> see <Ref Func="NmzExtremeRays"/>,</Item>
#! <Item><C>VerticesOfPolyhedron</C> see <Ref Func="NmzVerticesOfPolyhedron"/>,</Item>
#! <Item><C>SupportHyperplanes</C> see <Ref Func="NmzSupportHyperplanes"/>,</Item>
#! <Item><C>TriangulationSize</C> see <Ref Func="NmzTriangulationSize"/>,</Item>
#! <Item><C>TriangulationDetSum</C> see <Ref Func="NmzTriangulationDetSum"/>,</Item>
#! <Item><C>Triangulation</C> see <Ref Func="NmzTriangulation"/>,</Item>
#! <Item><C>Multiplicity</C> see <Ref Func="NmzMultiplicity"/>,</Item>
#! <Item><C>RecessionRank</C> see <Ref Func="NmzRecessionRank"/>,</Item>
#! <Item><C>AffineDim</C> see <Ref Func="NmzAffineDim"/>,</Item>
#! <Item><C>ModuleRank</C> see <Ref Func="NmzModuleRank"/>,</Item>
#! <Item><C>HilbertBasis</C> see <Ref Func="NmzHilbertBasis"/>,</Item>
#! <Item><C>ModuleGenerators</C> see <Ref Func="NmzModuleGenerators"/>,</Item>
#! <Item><C>Deg1Elements</C> see <Ref Func="NmzDeg1Elements"/>,</Item>
#! <Item><C>HilbertSeries</C> see <Ref Func="NmzHilbertSeries"/>,</Item>
#! <Item><C>HilbertQuasiPolynomial</C> see <Ref Func="NmzHilbertQuasiPolynomial"/>,</Item>
#! <Item><C>Grading</C> see <Ref Func="NmzGrading"/>,</Item>
#! <Item><C>IsPointed</C> see <Ref Func="NmzIsPointed"/>,</Item>
#! <Item><C>IsDeg1ExtremeRays</C> see <Ref Func="NmzIsDeg1ExtremeRays"/>,</Item>
#! <Item><C>IsDeg1HilbertBasis</C> see <Ref Func="NmzIsDeg1HilbertBasis"/>,</Item>
#! <Item><C>IsIntegrallyClosed</C> see <Ref Func="NmzIsIntegrallyClosed"/>,</Item>
#! <Item><C>OriginalMonoidGenerators</C> see <Ref Func="NmzOriginalMonoidGenerators"/>,</Item>
#! <Item><C>IsReesPrimary</C> see <Ref Func="NmzIsReesPrimary"/>,</Item>
#! <Item><C>ReesPrimaryMultiplicity</C> see <Ref Func="NmzReesPrimaryMultiplicity"/>,</Item>
#! <Item><C>ExcludedFaces</C> see <Ref Func="NmzExcludedFaces"/>,</Item>
#! <Item><C>Dehomogenization</C> see <Ref Func="NmzDehomogenization"/>,</Item>
#! <Item><C>InclusionExclusionData</C> see <Ref Func="NmzInclusionExclusionData"/>,</Item>
#! <Item><C>ClassGroup</C> see <Ref Func="NmzClassGroup"/>,</Item>
#! <Item><C>ModuleGeneratorsOverOriginalMonoid</C> see <Ref Func="NmzModuleGeneratorsOverOriginalMonoid"/>,</Item>
#! <Item><C>Sublattice</C> computes the efficient sublattice and returns a bool signaling
#! whether the computation was successful. Actual data connected to
#! it can be accessed by <Ref Func="NmzRank"/>, <Ref Func="NmzEquations"/>,
#! <Ref Func="NmzCongruences"/>, and <Ref Func="NmzBasisChange"/>.</Item>
#! </List>
#!
#! Additionally also the following compute options are accepted as property. They modify what and how should be computed, and return True after a successful computation.
#! <List>
#! <Item><C>Approximate</C> approximate the rational polytope by an integral polytope, currently only useful in combination with <C>Deg1Elements</C>.</Item>
#! <Item><C>BottomDecomposition</C> use the best possible triangulation (with respect to the sum of determinants) using the given generators.</Item>
#! <Item><C>DefaultMode</C> try to compute what is possible and do not throw an exception when something cannot be computed.</Item>
#! <Item><C>DualMode</C>activates the dual algorithm for the computation of the Hilbert basis and degree
#! 1 elements. Includes <C>HilbertBasis</C>, unless <C>Deg1Elements</C> is set. Often a good choice if you start from constraints.</Item>
#! <Item><C>KeepOrder</C> forbids to reorder the generators. Blocks <C>BottomDecomposition</C>.</Item>
#! </List>
#!
#! All the properties above can be given to <Ref Func="NmzCompute"/>. There you can
#! combine different properties, e.g. give some properties that you would like to know and add some compute options.
#! <P/>
#! See the Normaliz manual for a detailed description.
#!
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
#! <M>\mathbb{Z}^n \to \mathbb{Z}^r, u \mapsto (uB)/c</M>
#! and the inverse operation
#! <M>\mathbb{Z}^r \to \mathbb{Z}^n, v \mapsto vA</M>.
#! <P/>
#! This is part of the cone property <Q>Sublattice</Q>.
DeclareGlobalFunction( "NmzBasisChange" );


#! @Section Create a NmzCone
#! @Arguments list
#! @Returns NmzCone
#! @Description
#! Creates a NmzCone. The <A>list</A> argument should contain an even number of
#! elements, alternating between a string and a integer matrix. The string has to
#! correspond to a Normaliz input type string and the following matrix will be
#! interpreted as input of that type.
#!
#! See the Normaliz manual for the Normaliz version loaded by your version
#! of NormalizInterface for a detailed description of which input type strings
#! are supported and what arguments they take.
#!
#! @InsertChunk NmzCone_example
DeclareGlobalFunction( "NmzCone" );
