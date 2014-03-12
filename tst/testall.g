LoadPackage("NormalizInterface");
d := DirectoriesPackageLibrary("NormalizInterface", "tst");

# Little helper for testing outputs
NmzPropFingerprint := function(cone, prop)
    local tmp;
    if not NmzHasConeProperty(cone, prop) then
        return fail;
    fi;
    tmp := NmzConeProperty(cone, prop);
    if IsCyc(tmp) then
        return tmp;
    elif IsMatrix(tmp) then
        return Length(tmp);
    fi;
    return tmp;
end;

HasSuffix := function(list, suffix)
  local len;
  len := Length(list);
  if Length(list) < Length(suffix) then return false; fi;
  return list{[len-Length(suffix)+1..len]} = suffix;
end;

# Load all tests in that directory
tests := DirectoryContents(d[1]);
tests := Filtered(tests, name -> HasSuffix(name, ".tst"));
Sort(tests);

# Convert tests to filenames
tests := List(tests, test -> Filename(d,test));

# Run the tests
for test in tests do
    Test(test, rec(compareFunction:="uptowhitespace"));
od;
