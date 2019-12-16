#
# Generate the manual using AutoDoc
#
if fail = LoadPackage("AutoDoc", ">= 2019.04.10") then
    Error("AutoDoc 2019.04.10 or newer is required");
fi;

AutoDoc(rec(
    extract_examples := true,
    scaffold := rec( bib := "NormalizInterface-bib.xml" ),
    autodoc := rec( files := [ "doc/intro.autodoc", "src/normaliz.cc" ] ),
));
QUIT;
