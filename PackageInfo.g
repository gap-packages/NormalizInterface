SetPackageInfo( rec(

PackageName := "NormalizInterface",
Subtitle := "GAP wrapper for Normaliz",
Version := "1.0.2",
Date    := "03/12/2017", # dd/mm/yyyy format

Persons := [
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "gutsche@mathematik.uni-siegen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    PostalAddress := Concatenation(
                       "Department of Mathematics\n",
                       "University of Siegen\n",
                       "57072 Kaiserslautern\n",
                       "Germany" ),
    Place         := "Siegen",
    Institution   := "University of Siegen"
  ),

  rec(
    LastName      := "Horn",
    FirstNames    := "Max",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "max.horn@math.uni-giessen.de",
    WWWHome       := "http://www.quendi.de/math",
    PostalAddress := Concatenation(
                       "AG Algebra\n",
                       "Mathematisches Institut\n",
                       "Justus-Liebig-Universität Gießen\n",
                       "Arndtstraße 2\n",
                       "35392 Gießen\n",
                       "Germany" ),
    Place         := "Gießen",
    Institution   := "Justus-Liebig-Universität Gießen"
  ),

  rec(
    LastName      := "Söger",
    FirstNames    := "Christof",
    IsAuthor      := true,
    IsMaintainer  := true,
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
  a GAP interface to <a href='http://www.home.uni-osnabrueck.de/wbruns/normaliz/'>Normaliz</a>,\
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
  GAP                    := ">= 4.8.1",
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

Autoload := false,

Keywords := [
  "normaliz",
  "cones"
],

TestFile := "tst/testall.g",

));
