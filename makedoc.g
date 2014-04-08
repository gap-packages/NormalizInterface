#
# Generate the manual using AutoDoc
#
LoadPackage("AutoDoc", "2014.03.04");

SetPackagePath("NormalizInterface", ".");
AutoDoc("NormalizInterface" : scaffold := true,
        autodoc := rec(
            files := [
                    "doc/intro.autodoc",
                    ]
            )
     );

PrintTo("VERSION", PackageInfo("NormalizInterface")[1].Version);

QUIT;
