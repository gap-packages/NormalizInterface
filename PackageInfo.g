SetPackageInfo( rec(

PackageName := "NormalizInterface",
Subtitle := "GAP wrapper for Normaliz",
Version := "0.9.2",
Date    := "07/01/2016", # dd/mm/yyyy format

Persons := [
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "gutsche@mathematik.uni-kl.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    PostalAddress := Concatenation(
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
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
    WWWHome       := "http://www.math.uos.de/normaliz",
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

PackageWWWHome := "https://gap-packages.github.io/NormalizInterface",
README_URL     := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL     := Concatenation("https://github.com/gap-packages/NormalizInterface/",
                                "releases/download/v", ~.Version,
                                "/NormalizInterface-", ~.Version),
ArchiveFormats := ".tar.gz .tar.bz2",

AbstractHTML :=
  "The <span class=\"pkgname\">NormalizInterface</span> package provides\
  a GAP interface to Normaliz, enabling direct access to the complete\
  functionality of Normaliz.",


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
  GAP                    := ">= 4.8",
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
