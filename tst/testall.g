LoadPackage("NormalizInterface");
dirs := DirectoriesPackageLibrary("NormalizInterface", "tst");

_NmzPrintSomeConeProperties := function(cone, excluded)
    local prop, val;
    if not IsNormalizCone(cone) then
        Error("First argument must be a Normaliz cone object");
        return;
    fi;
    excluded := Union(excluded, [ "ExplicitHilbertSeries" ]);
    # iterate over properties in alphabetical order, to reduce
    # fluctuations between Normaliz versions
    for prop in Set(NmzKnownConeProperties(cone)) do
        if prop in excluded then
            continue;
        fi;
        val := NmzConeProperty(cone, prop);
        Print(prop," = ");
        if IsMatrix(val) then
            Print("\n");
        fi;
        Display(val);
    od;
end;

TestDirectory(dirs, rec(exitGAP := true));
