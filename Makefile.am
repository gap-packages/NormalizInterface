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
NormalizInterface_la_CXXFLAGS = -Wall
NormalizInterface_la_CPPFLAGS = $(GAP_CPPFLAGS) -DCONFIG_H $(NORMALIZ_CPPFLAGS)
NormalizInterface_la_LDFLAGS = -R$(NORMALIZ_LDPATH)
NormalizInterface_la_LDFLAGS += -module -avoid-version
if SYS_IS_CYGWIN
NormalizInterface_la_LDFLAGS += -no-undefined -version-info 0:0:0 -Wl,$(GAPROOT)/bin/$(GAPARCH)/gap.dll
endif
NormalizInterface_la_LIBADD = $(NORMALIZ_LDFLAGS) -lnormaliz

all-local: $(GAPINSTALLLIB)

$(GAPINSTALLLIB): NormalizInterface.la
	$(mkdir_p) $(BINARCHDIR)
if SYS_IS_CYGWIN
	cp .libs/NormalizInterface.dll $(GAPINSTALLLIB)
else
	cp .libs/NormalizInterface.so $(GAPINSTALLLIB)
endif

clean-local: clean-doc
	rm -rf $(BINARCHDIR)

distclean-local: clean-doc
	rm -rf bin

doc:	doc/manual.six

clean-doc:
	rm -f doc/manual.*
	rm -f doc/NormalizInterface.*
	rm -f doc/*.{bib,css,html,js,txt}
	find doc/ -type f -name *.xml -and \( -not -name 'NormalizInterface-bib.xml' \) -delete

DOC_FILES = \
	PackageInfo.g \
	doc/*.autodoc \
	doc/*.xml \
	src/normaliz.cc \
	lib/cone_property_wrappers.gd \
	lib/normaliz.gd \
    examples/*.g \
	makedoc.g

doc/manual.six: $(DOC_FILES)
	($(GAPROOT)/bin/gap.sh -A makedoc.g)

AM_COLOR_TESTS = always
TESTS_ENVIRONMENT = GAP_EXECUTABLE='$(GAPROOT)/bin/gap.sh'
TESTS = tst/run-tap.test
TEST_LOG_DRIVER = $(SHELL) $(top_srcdir)/tst/tap-driver.sh


.PHONY: doc
