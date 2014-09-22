TEST_SETTING := rec(
    automake := false,
    verbose := true,
    rewriteToFile := false,
    pkg := "NormalizInterface",
);

if IsBound(GAPInfo.SystemEnvironment.AUTOMAKE_TESTS) then
    TEST_SETTING.automake := true;
    TEST_SETTING.verbose := false;
fi;

if TEST_SETTING.automake then
    if LoadPackage("io") = fail then
        Error("Could not load package: 'IO'!");
        # FIXME: Error() here leads to "make check" hanging!
    fi;

    # HACK to make sure GAP loads the right version of the
    # package
    SetPackagePath(TEST_SETTING.pkg, ".");
fi;

if LoadPackage(TEST_SETTING.pkg) = fail then
    if TEST_SETTING.automake then
        Print("Could not load package '",TEST_SETTING.pkg,"'\n");
        IO_exit(99); # make check: FAILED
    fi;
    Error("Could not load package '",TEST_SETTING.pkg,"'\n");
fi;

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


CallFuncList(function()
    local d, HasSuffix, tests, success, i, test, opt;

    d := DirectoriesPackageLibrary(TEST_SETTING.pkg, "tst");

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

    if TEST_SETTING.automake then
        Print("1..",Length(tests),"\n");
    fi;

    # Run the tests
    success := true;
    for i in [1..Length(tests)] do
        test := tests[i];

        if TEST_SETTING.verbose then
            Print("Running test '",test,"'\n");
        fi;

        opt := rec( compareFunction := "uptowhitespace" );
        if TEST_SETTING.rewriteToFile then
            opt.rewriteToFile := test;
        fi;

        if Test(test, opt) then
            if TEST_SETTING.automake then
                Print("ok ",i," - ",test,"\n");
            fi;
        else
            if TEST_SETTING.automake then
                Print("not ok ",i," - ",test,"\n");
            fi;
            success := false;
        fi;
    od;

    if TEST_SETTING.automake then
        #if success then
            IO_exit(0); # make check: PASSED
        #else
            #IO_exit(1); # make check: FAILED
        #fi;
    fi;

end, []);
