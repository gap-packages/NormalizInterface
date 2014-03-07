NormalizObjectFamily := NewFamily( "NormalizObjectFamily" );

DeclareCategory( "IsNormalizConeObject", IsObject );

BindGlobal("TheTypeNormalizCone", NewType( NormalizObjectFamily, IsNormalizConeObject ));
