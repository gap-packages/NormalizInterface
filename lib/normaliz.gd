NormalizObjectFamily := NewFamily( "NormalizObjectFamily" );

DeclareCategory( "IsNormalizCone", IsObject );

DeclareCategory( "IsNormalizLongIntCone", IsNormalizCone );
DeclareCategory( "IsNormalizGMPCone", IsNormalizCone );

BindGlobal("TheTypeNormalizLongIntCone", NewType( NormalizObjectFamily, IsNormalizLongIntCone ));
BindGlobal("TheTypeNormalizGMPCone", NewType( NormalizObjectFamily, IsNormalizGMPCone ));

DeclareOperation( "NmzConeProperty", [IsNormalizCone, IsString] );
