_NORMALIZ_SO:=Filename(DirectoriesPackagePrograms("GAPnormaliz"), "normaliz.so");
if _NORMALIZ_SO <> fail then
    LoadDynamicModule(_NORMALIZ_SO);
fi;

ReadPackage("GAPnormaliz", "lib/normaliz.gd");
