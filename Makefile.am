#
# NormalizInterface: 
#
# This file is part of the build system of a GAP kernel extension.
# Requires automake.
#
ACLOCAL_AMFLAGS = -I m4

BINARCHDIR = bin/$(GAPARCH)
GAPINSTALLLIB = $(BINARCHDIR)/NormalizInterface.so

lib_LTLIBRARIES = NormalizInterface.la

NormalizInterface_la_SOURCES = src/normaliz.cc
NormalizInterface_la_CPPFLAGS = $(GAP_CPPFLAGS) -DCONFIG_H $(NORMALIZ_CPPFLAGS)
NormalizInterface_la_LDFLAGS = -R$(NORMALIZ_LDPATH)
NormalizInterface_la_LDFLAGS += -module -avoid-version
if SYS_IS_CYGWIN
NormalizInterface_la_LDFLAGS += -no-undefined -version-info 0:0:0 -Wl,$(GAPROOT)/bin/$(GAPARCH)/gap.dll
endif
NormalizInterface_la_LIBADD = $(NORMALIZ_LDFLAGS) -lnormaliz

all-local: NormalizInterface.la lib/cone_property_wrappers.gi
	$(mkdir_p) $(BINARCHDIR)
if SYS_IS_CYGWIN
	cp .libs/NormalizInterface.dll $(GAPINSTALLLIB)
else
	cp .libs/NormalizInterface.so $(GAPINSTALLLIB)
endif
	@echo "SUCCESS!"

clean-local: clean-doc
	rm -rf $(BINARCHDIR)

distclean-local: clean-doc
	rm -rf bin

doc:	doc/manual.six

clean-doc:
	rm -f doc/manual.*
	rm -f doc/NormalizInterface.*
	rm -f doc/*.{css,html,js,txt,xml}

DOC_FILES = \
	PackageInfo.g \
	doc/*.autodoc \
	src/normaliz.cc \
	lib/cone_property_wrappers.gd \
	lib/normaliz.gd \
	makedoc.g

doc/manual.six: $(DOC_FILES)
	($(GAPROOT)/bin/gap.sh -A makedoc.g)

lib/cone_property_wrappers.gi: lib/cone_property_wrappers.gd

lib/cone_property_wrappers.gd: gen_cone_property_wrappers.sh
	./gen_cone_property_wrappers.sh

BUILT_SOURCES = \
	lib/cone_property_wrappers.gi \
	lib/cone_property_wrappers.gd

CLEANFILES = \
	lib/cone_property_wrappers.gi \
	lib/cone_property_wrappers.gd
