## This is an automatically generated file

#! @Chapter Functions
#! @Section Cone properties

#! @Arguments cone
#! @Returns the affine dimension
#! @Description
#! The affine dimension of the polyhedron in inhomogeneous computations. Its computation is triggered if necessary.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "AffineDim" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzAffineDim" );

#! @Arguments cone
#! @Returns the class group in a special format
#! @Description
#! A normal affine monoid $M$ has a well-defined divisor class group.
#! It is naturally isomorphic to the divisor class group of $K[M]$ where $K$
#! is a field (or any unique factorization domain).
#! We represent it as a vector where the first entry is the rank. It is
#! followed by sequence of pairs of entries <M>n,m</M>. Such two entries
#! represent a free cyclic summand <M>(\mathbb{Z}/n\mathbb{Z})^m</M>.
#! Not allowed in inhomogeneous computations.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "ClassGroup" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzClassGroup" );

#! @Arguments cone
#! @Returns a matrix whose rows are the degree 1 elements
#! @Description
#! Requires the presence of a grading. Not allowed in inhomogeneous computations.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "Deg1Elements" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzDeg1Elements" );

#! @Arguments cone
#! @Returns the dehomgenization vector
#! @Description
#! Only for inhomogeneous computations.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "Dehomogenization" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzDehomogenization" );

#! @Arguments cone
#! @Returns a matrix whose rows represent the excluded faces
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "ExcludedFaces" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzExcludedFaces" );

#! @Arguments cone
#! @Returns a matrix whose rows are the extreme rays
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "ExtremeRays" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzExtremeRays" );

#! @Arguments cone
#! @Returns a matrix whose rows are the generators
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "Generators" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzGenerators" );

#! @Arguments cone
#! @Returns the grading vector
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "Grading" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzGrading" );

#! @Arguments cone
#! @Returns a matrix whose rows are the Hilbert basis elements
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "HilbertBasis" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzHilbertBasis" );

#! @Arguments cone
#! @Returns the Hilbert function as a quasipolynomial
#! @Description
#! The Hilbert function counts the lattice points degreewise. The result is a
#! quasipolynomial <M>Q</M>, that is, a polynomial with periodic coefficients. It is
#! given as list of polynomials <M>P_0, \ldots, P_{(p-1)}</M> such that <M>Q(i) = P_{(i \bmod p)} (i)</M>.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "HilbertQuasiPolynomial" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzHilbertQuasiPolynomial" );

#! @Arguments cone
#! @Returns the Hilbert series as rational function
#! @Description
#! The result consists of a list with two entries. The first is the numerator
#! polynomial. In inhomogeneous computations this can also be a Laurent
#! polynomial. The second list entry represents the denominator. It is a list
#! of pairs <M>[k_i, l_i]</M>. Such a pair represents the factor <M>(1-t^{k_i})^{l_i}</M>.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "HilbertSeries" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzHilbertSeries" );

#! @Arguments cone
#! @Returns inclusion-exclusion data
#! @Description
#! List of faces which are internally have been used in the inclusion-exclusion
#! scheme. Given as a list pairs. The first pair entry is a key of generators
#! contained in the face (compare also <Ref Func="NmzTriangulation"/>) and the
#! multiplicity with which it was considered.
#! Only available with excluded faces or strict constraints as input.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "InclusionExclusionData" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzInclusionExclusionData" );

#! @Arguments cone
#! @Returns <K>true</K> if all extreme rays have degree 1; <K>false</K> otherwise
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "IsDeg1ExtremeRays" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzIsDeg1ExtremeRays" );

#! @Arguments cone
#! @Returns <K>true</K> if all Hilbert basis elements have degree 1; <K>false</K> otherwise
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "IsDeg1HilbertBasis" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzIsDeg1HilbertBasis" );

#! @Arguments cone
#! @Returns <K>true</K> if the cone is integrally closed; <K>false</K> otherwise
#! @Description
#! It is integrally closed when the Hilbert basis is a subset of the original monoid generators. So it is only computable if we have original monoid generators.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "IsIntegrallyClosed" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzIsIntegrallyClosed" );

#! @Arguments cone
#! @Returns <K>true</K> if the cone is pointed; <K>false</K> otherwise
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "IsPointed" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzIsPointed" );

#! @Arguments cone
#! @Returns a matrix whose rows generate the maximale linear subspace
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "MaximalSubspace" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzMaximalSubspace" );

#! @Arguments cone
#! @Returns a matrix whose rows are the module generators
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "ModuleGenerators" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzModuleGenerators" );

#! @Arguments cone
#! @Returns a matrix whose rows are the module generators over the original monoid
#! @Description
#! A minimal system of generators of  the integral closure over the original monoid.
#! Requires the existence of original monoid generators. Not allowed in inhomogeneous computations.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "ModuleGeneratorsOverOriginalMonoid" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzModuleGeneratorsOverOriginalMonoid" );

#! @Arguments cone
#! @Returns the rank of the module of lattice points in the polyhedron as a module over the recession monoid
#! @Description
#! Only for inhomogeneous computations.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "ModuleRank" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzModuleRank" );

#! @Arguments cone
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "Multiplicity" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzMultiplicity" );

#! @Arguments cone
#! @Returns a matrix whose rows are the original monoid generators
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "OriginalMonoidGenerators" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzOriginalMonoidGenerators" );

#! @Arguments cone
#! @Returns the rank of the recession cone
#! @Description
#! Only for inhomogeneous computations.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "RecessionRank" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzRecessionRank" );

#! @Arguments cone
#! @Returns <K>true</K> if is the monomial ideal is primary to the irrelevant maximal ideal, <K>false</K> otherwise
#! @Description
#! Only used with the input type <C>rees_algebra</C>.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "IsReesPrimary" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzIsReesPrimary" );

#! @Arguments cone
#! @Description
#! the multiplicity of a monomial ideal, provided it is primary to the maximal
#! ideal generated by the indeterminates. Used only with the input type
#! <C>rees_algebra</C>.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "ReesPrimaryMultiplicity" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzReesPrimaryMultiplicity" );

#! @Arguments cone
#! @Returns a matrix whose rows represent the support hyperplanes
#! @Description
#! The equations cut out the linear space generated by the cone.
#! Together with the support hyperplanes and the congruences it describes the
#! lattice points of the cone.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "SupportHyperplanes" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzSupportHyperplanes" );

#! @Arguments cone
#! @Returns the triangulation
#! @Description
#! It is given as a list of pairs representing the maximal simplicial cones in the triangulation. The first pair entry is the key of the simplex, i.e. the indices of the generators with respect th the generators obtained by <Ref Func="NmzGenerators"/> (counting from 0). The second pair entry is the absolute value of the determinant of the generator matrix.
#! <P/>
#! This is an alias for <C>NmzConeProperty( cone, "Triangulation" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzTriangulation" );

#! @Arguments cone
#! @Returns sum of the absolute values of the determinants of the simplicial cones in the used triangulation
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "TriangulationDetSum" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzTriangulationDetSum" );

#! @Arguments cone
#! @Returns the number of simplicial cones in the used triangulation
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "TriangulationSize" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzTriangulationSize" );

#! @Arguments cone
#! @Returns a matrix whose rows are the vertices of the polyhedron
#! @Description
#! This is an alias for <C>NmzConeProperty( cone, "VerticesOfPolyhedron" );</C> see <Ref Func="NmzConeProperty"/>.
DeclareGlobalFunction( "NmzVerticesOfPolyhedron" );

