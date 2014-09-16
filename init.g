_NORMALIZ_SO:=Filename(DirectoriesPackagePrograms("NormalizInterface"), "NormalizInterface.so");
if _NORMALIZ_SO <> fail then
    LoadDynamicModule(_NORMALIZ_SO);
fi;
Unbind(_NORMALIZ_SO);

ReadPackage("NormalizInterface", "lib/normaliz.gd");

ReadPackage("NormalizInterface", "lib/cone_property_wrappers.gd" );
