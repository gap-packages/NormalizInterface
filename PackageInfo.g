SetPackageInfo( rec(

PackageName := "GAPnormaliz",
Subtitle := "GAP wrapper for normaliz",
Version := "0.1dev",
Date    := "??/03/2014",

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
    #WWWHome       := "http://",
    PostalAddress := Concatenation(
                       "Institut für Mathematik\n",
                       "Albrechtstr. 28a\n",
                       "49076 Osnabrück" ),
    Place         := "Osnabrück",
    Institution   := "University of Osnabrück"
  ),
],

Status         := "dev",
#CommunicatedBy := "name (place)",
#AcceptDate     := "mm/yyyy",

PackageWWWHome := "https://github.com/fingolfin/GAPnormaliz",

ArchiveFormats := ".tar.gz tar.bz2",
ArchiveURL     := Concatenation( ~.PackageWWWHome, "GAPnormaliz-",~.Version),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML   := Concatenation(
               "The GAPnormaliz Package ... ",
               "TODO"),

PackageDoc := rec(
  BookName  := "GAPnormaliz",
  ArchiveURLSubset := [ "doc" ],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "GAP wrapper for normaliz",
  Autoload  := true
),

Dependencies := rec(
  GAP                    := ">= 4.7",
  NeededOtherPackages    := [ ],
  SuggestedOtherPackages := [ ],
  ExternalConditions     := [ ]
),

AvailabilityTest := function()
    local path;
    # test for existence of the compiled binary
    path := DirectoriesPackagePrograms("GAPnormaliz");
    if not "normaliz" in SHOW_STAT() and
       Filename(path, "normaliz.so") = fail then
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
