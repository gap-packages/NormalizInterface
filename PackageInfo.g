SetPackageInfo( rec(

PackageName := "NormalizInterface",
Subtitle := "GAP wrapper for Normaliz",
Version := "1.4.1",
Date    := "20/06/2025", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "gutsche@mathematik.uni-siegen.de",
  ),

  rec(
    LastName      := "Horn",
    FirstNames    := "Max",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "mhorn@rptu.de",
    WWWHome       := "https://www.quendi.de/math",
    PostalAddress := Concatenation(
                       "Fachbereich Mathematik\n",
                       "RPTU Kaiserslautern-Landau\n",
                       "Gottlieb-Daimler-Straße 48\n",
                       "67663 Kaiserslautern\n",
                       "Germany" ),
    Place         := "Kaiserslautern, Germany",
    Institution   := "RPTU Kaiserslautern-Landau"
  ),

  rec(
    LastName      := "Söger",
    FirstNames    := "Christof",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "csoeger@uos.de",
  ),
],

Status         := "deposited",
#CommunicatedBy := "name (place)",
#AcceptDate     := "mm/yyyy",

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://gap-packages.github.io/", ~.PackageName ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),
ArchiveFormats  := ".tar.gz .tar.bz2",

AbstractHTML :=
  "The <span class='pkgname'>NormalizInterface</span> package provides\
  a GAP interface to <a href='https://www.normaliz.uni-osnabrueck.de'>Normaliz</a>,\
  enabling direct access to the complete functionality of Normaliz, such as\
  computations in affine monoids, vector configurations, lattice polytopes, and rational cones.\
  ",


PackageDoc := rec(
  BookName  := "NormalizInterface",
  ArchiveURLSubset := [ "doc" ],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "GAP wrapper for Normaliz",
),

Dependencies := rec(
  GAP                    := ">= 4.12.1",
  NeededOtherPackages    := [ ],
  SuggestedOtherPackages := [ ],
  ExternalConditions     := [ ]
),

AvailabilityTest := function()
    local path;
    # test for existence of the compiled binary
    if not IsKernelExtensionAvailable("NormalizInterface") then
       LogPackageLoadingMessage( PACKAGE_WARNING,
           [ "kernel functions for NormalizInterface not available." ] );
      return false;
    fi;
    return true;
  end,


# Show the Normaliz version number in the banner string.
# (We assume that this function gets called *after* the package has been
# loaded, in particular after libnormaliz has been loaded.)
BannerFunction := function( info )
  local str, version;

  str := DefaultPackageBannerString( info );
  if not IsBoundGlobal( "_NmzVersion" ) then
    return str;
  fi;
  version := ValueGlobal( "_NmzVersion" )();
  version := JoinStringsWithSeparator(version, ".");

  return ReplacedString( str, "by Sebastian",
             Concatenation( "(Normaliz version is ", version, ")\n", "by Sebastian" ) );
end,

Keywords := [
  "normaliz",
  "cones"
],

TestFile := "tst/testall.g",

));
