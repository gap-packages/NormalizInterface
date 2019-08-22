SetPackageInfo( rec(

PackageName := "NormalizInterface",
Subtitle := "GAP wrapper for Normaliz",
Version := "1.1.0",
Date    := "23/08/2019", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "gutsche@mathematik.uni-siegen.de",
    WWWHome       := "https://algebra.mathematik.uni-siegen.de/gutsche/",
    PostalAddress := Concatenation(
                       "Department Mathematik\n",
                       "Universität Siegen\n",
                       "Walter-Flex-Straße 3\n",
                       "57072 Siegen\n",
                       "Germany" ),
    Place         := "Siegen",
    Institution   := "Universität Siegen"
  ),

  rec(
    LastName      := "Horn",
    FirstNames    := "Max",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "max.horn@uni-siegen.de",
    WWWHome       := "https://www.quendi.de/math",
    PostalAddress := Concatenation(
                       "Department Mathematik\n",
                       "Universität Siegen\n",
                       "Walter-Flex-Straße 3\n",
                       "57072 Siegen\n",
                       "Germany" ),
    Place         := "Siegen",
    Institution   := "Universität Siegen"
  ),

  rec(
    LastName      := "Söger",
    FirstNames    := "Christof",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "csoeger@uos.de",
    WWWHome       := "https://www.normaliz.uni-osnabrueck.de",
    PostalAddress := Concatenation(
                       "Institut für Mathematik\n",
                       "Albrechtstr. 28a\n",
                       "49076 Osnabrück\n",
                       "Germany" ),
    Place         := "Osnabrück",
    Institution   := "University of Osnabrück"
  ),
],

Status         := "dev",
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
  Autoload  := true
),

Dependencies := rec(
  GAP                    := ">= 4.9",
  NeededOtherPackages    := [ ],
  SuggestedOtherPackages := [ ],
  ExternalConditions     := [ ]
),

AvailabilityTest := function()
    local path;
    # test for existence of the compiled binary
    path := DirectoriesPackagePrograms("NormalizInterface");
    if not "NormalizInterface" in SHOW_STAT() and
       Filename(path, "NormalizInterface.so") = fail then
       LogPackageLoadingMessage( PACKAGE_WARNING,
           [ "kernel functions for NormalizInterface not available." ] );
      return fail;
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
