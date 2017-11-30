LoadPackage("NormalizInterface");
dirs := DirectoriesPackageLibrary("NormalizInterface", "tst");
TestDirectory(dirs, rec(exitGAP := true));
