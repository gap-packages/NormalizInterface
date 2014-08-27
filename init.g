_NORMALIZ_SO:=Filename(DirectoriesPackagePrograms("NormalizInterface"), "normaliz.so");
if _NORMALIZ_SO <> fail then
    LoadDynamicModule(_NORMALIZ_SO);
fi;
Unbind(_NORMALIZ_SO);

ReadPackage("NormalizInterface", "lib/normaliz.gd");
