#
# Generate the manual using AutoDoc
#
LoadPackage("AutoDoc", "2014.03.04");

SetPackagePath("NormalizInterface", ".");
AutoDoc("NormalizInterface" : scaffold := true,
        maketest := rec ( commands := [ "LoadPackage(\"NormalizInterface\");" ] ),
        autodoc := rec(
            files := [
                    "doc/intro.autodoc",
                    "src/normaliz.cc",
                    ]
            )
     );

PrintTo("VERSION", PackageInfo("NormalizInterface")[1].Version);

QUIT;
