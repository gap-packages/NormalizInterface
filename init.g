if LoadKernelExtension("NormalizInterface") = false then
    Error("failed to load NormalizInterface kernel extension");
fi;

ReadPackage("NormalizInterface", "lib/normaliz.gd");

ReadPackage("NormalizInterface", "lib/cone_property_wrappers.gd" );
