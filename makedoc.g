#
# Generate the manual using AutoDoc
#
if fail = LoadPackage("AutoDoc", ">= 2016.01.21") then
    Error("AutoDoc 2016.01.21 or newer is required");
fi;

AutoDoc(rec(
    maketest := rec( commands := [ "LoadPackage(\"NormalizInterface\");" ] ),
    scaffold := rec( bib := "NormalizInterface-bib.xml" ),
    autodoc := rec( files := [ "doc/intro.autodoc", "src/normaliz.cc" ] ),
));
