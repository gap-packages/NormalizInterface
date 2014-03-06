############################################################################
#
# Load the (optional) C part
#
if Filename(DirectoriesPackagePrograms("GAPnormaliz"), "normaliz.so") <> fail then
	LoadDynamicModule(Filename(DirectoriesPackagePrograms("GAPnormaliz"), "normaliz.so"));
fi;


############################################################################
##
#D Read .gd files
##

ReadPackage("GAPnormaliz", "lib/normaliz.gd");
