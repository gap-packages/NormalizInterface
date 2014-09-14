#
# NormalizInterface: 
#
# This file is part of the build system of a GAP kernel extension.
# Requires automake.
#
ACLOCAL_AMFLAGS = -I m4

BINARCHDIR = bin/$(GAPARCH)
GAPINSTALLLIB = $(abs_top_srcdir)/$(BINARCHDIR)/NormalizInterface.so

lib_LTLIBRARIES = NormalizInterface.la

NormalizInterface_la_SOURCES = src/normaliz.cc
NormalizInterface_la_CPPFLAGS = $(GAP_CPPFLAGS) -DCONFIG_H $(NORMALIZ_CPPFLAGS)
NormalizInterface_la_LDFLAGS = $(NORMALIZ_LDFLAGS)
NormalizInterface_la_LDFLAGS += -module -avoid-version
if SYS_IS_CYGWIN
NormalizInterface_la_LDFLAGS += -no-undefined -version-info 0:0:0 -Wl,$(GAPROOT)/bin/$(GAPARCH)/gap.dll
endif
NormalizInterface_la_LIBADD = -lnormaliz

all-local: NormalizInterface.la lib/cone_property_function.gi
	$(mkdir_p) $(top_srcdir)/$(BINARCHDIR)
if SYS_IS_CYGWIN
	cp .libs/NormalizInterface.dll $(GAPINSTALLLIB)
else
	cp .libs/NormalizInterface.so $(GAPINSTALLLIB)
endif
	@echo "SUCCESS!"

clean-local: clean-doc

distclean-local: clean-doc
	rm -rf bin/*

doc:	doc/manual.six

clean-doc:
	rm -f doc/manual.*
	rm -f doc/NormalizInterface.*
	rm -f doc/*.{css,html,js,txt,xml}

doc/manual.six: doc/*.xml PackageInfo.g
	($(GAPROOT)/bin/gap.sh -A makedoc.g)

lib/cone_property_function.gi: lib/cone_property_function.gd

lib/cone_property_function.gd: cone_property_install_script.sh
	./cone_property_install_script.sh
