TEST_SETTING := rec(
    automake := false,
    verbose := true,
    rewriteToFile := false,
    pkg := "NormalizInterface",
    abort := false,
);

if IsBound(GAPInfo.SystemEnvironment.AUTOMAKE_TESTS) then
    TEST_SETTING.automake := true;
    TEST_SETTING.verbose := false;

    # abort immediately upon any error, instead of getting stuck
    # in a break loop
    OnBreak := function() QUIT_GAP(1); end;

    # HACK to make sure GAP loads the right version of the package
    SetPackagePath(TEST_SETTING.pkg, ".");
fi;


if not TEST_SETTING.abort and LoadPackage(TEST_SETTING.pkg) = fail then
    if TEST_SETTING.automake then
        Print("\nBail out! Could not load package '",TEST_SETTING.pkg,"'\n");
        TEST_SETTING.abort := true;
    else
        Error("Could not load package '",TEST_SETTING.pkg,"'\n");
    fi;
fi;

if not TEST_SETTING.abort then
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
            QUIT_GAP(0); # make check: PASSED
        #else
            #QUIT_GAP(1); # make check: FAILED
        #fi;
    fi;

end, []);
fi;

QUIT_GAP();
