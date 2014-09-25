NormalizObjectFamily := NewFamily( "NormalizObjectFamily" );

DeclareCategory( "IsNormalizConeObject", IsObject );

DeclareCategory( "IsNormalizLongIntConeObject", IsNormalizConeObject );
DeclareCategory( "IsNormalizGMPConeObject", IsNormalizConeObject );

BindGlobal("TheTypeNormalizLongIntCone", NewType( NormalizObjectFamily, IsNormalizLongIntConeObject ));
BindGlobal("TheTypeNormalizGMPCone", NewType( NormalizObjectFamily, IsNormalizGMPConeObject ));

DeclareOperation( "NmzConeProperty", [IsNormalizConeObject, IsString] );
