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
