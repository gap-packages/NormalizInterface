LoadPackage("AutoDoc");

AutoDoc( "GAPnormaliz" : scaffold := true,
        autodoc := rec(
            files := [
                    "doc/intro.autodoc",
                    ]
            )
     );

PrintTo( "VERSION", PackageInfo( "GAPnormaliz" )[1].Version );

QUIT;
