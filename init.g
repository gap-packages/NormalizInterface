_NORMALIZ_SO:=Filename(DirectoriesPackagePrograms("NormalizInterface"), "normaliz.so");
if _NORMALIZ_SO <> fail then
    LoadDynamicModule(_NORMALIZ_SO);
fi;

ReadPackage("NormalizInterface", "lib/normaliz.gd");
