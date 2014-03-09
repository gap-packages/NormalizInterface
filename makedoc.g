LoadPackage("AutoDoc");

AutoDoc( "NormalizInterface" : scaffold := true,
        autodoc := rec(
            files := [
                    "doc/intro.autodoc",
                    ]
            )
     );

PrintTo( "VERSION", PackageInfo( "NormalizInterface" )[1].Version );

QUIT;
