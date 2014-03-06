############################################################################
#
# Load the (optional) C part
#
if Filename(DirectoriesPackagePrograms("normaliz"), "normaliz.so") <> fail then
	LoadDynamicModule(Filename(DirectoriesPackagePrograms("normaliz"), "normaliz.so"));
fi;


############################################################################
##
#D Read .gd files
##

ReadPackage("GAPnormaliz", "lib/normaliz.gd");
