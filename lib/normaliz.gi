##
InstallMethod( ViewString,
               "for a Normaliz cone",
               [ IsNormalizCone ],
function( r )
    # TODO: May print more information when present
    return "<a Normaliz cone>";
end );

InstallGlobalFunction( NmzConeProperty,
function( cone, prop )
    local result, t, shift, poly, tmp, denom;
    result := _NmzConeProperty(cone, prop);
    if prop = "Grading" then
        denom := Remove(result);
        return result / denom;
    fi;
    if prop = "HilbertSeries" then
        t := Indeterminate(Integers, "t");
        poly := UnivariatePolynomial(Integers, result[1], t);
        shift := result[3];
        if shift > 0 then
            poly := poly * t^shift;
        fi;
        if shift < 0 then
            poly := poly / t^(-shift);
        fi;
        tmp := Collected(result[2]);
        return [poly, tmp];
    fi;
    if prop = "HilbertQuasiPolynomial" then
        t := Indeterminate(Rationals, "t");
        denom := Remove(result);
        poly := List(result, coeffs -> UnivariatePolynomial(Rationals, coeffs, t));
        return poly / denom;
    fi;
    return result;
end );

InstallGlobalFunction("NmzPrintConeProperties", function(cone)
    local prop, val;
    if not IsNormalizCone(cone) then
        Error("First argument must be a Normaliz cone object");
        return;
    fi;
    for prop in NmzKnownConeProperties(cone) do
        val := NmzConeProperty(cone, prop);
        Print(prop," = ");
        if IsMatrix(val) then
            Print("\n");
        fi;
        Display(val);
    od;
end);


InstallGlobalFunction( NmzBasisChange,
function( cone )
    local result;
    result := NmzConeProperty( cone, "Sublattice" );
    return rec(
        Embedding := result[1],
        Projection := result[2],
        Annihilator := result[3],
        );
end );


#
#
#
InstallGlobalFunction("NmzCone", function(arg)
    local func, opts_rec, opts_list, cone;
    if Length(arg) = 1 then
        if IsList(arg[1]) then
            opts_list := arg[1];
        #elif IsRecord(arg[1]) then
        #   TODO
        else
            # TODO: better error message
            Error("Unsupported input");
        fi;
    else
        opts_list := arg;
    fi;

    cone := _NmzCone(opts_list);
    return cone;
end);

# TODO: extend NmzCone to allow this syntax:
##cone := NmzCone(rec(integral_closure := M, grading := [ 0, 0, 1 ]));;



#
#
#
InstallGlobalFunction("NmzCompute", function(arg)
    local cone, propsToCompute;
    if not Length(arg) in [1,2] then
        Error("Wrong number of arguments, expected 1 or 2");
        return fail;
    fi;
    cone := arg[1];
    if not IsNormalizCone(cone) then
        Error("First argument must be a Normaliz cone object");
        return fail;
    fi;
    if Length(arg) = 1 then
        propsToCompute := [];
        if ValueOption("dual") = true then Add(propsToCompute, "DualMode"); fi;
        if ValueOption("DualMode") = true then Add(propsToCompute, "DualMode"); fi;
        if ValueOption("HilbertBasis") = true then Add(propsToCompute, "HilbertBasis"); fi;
        # TODO: add more option names? or just support arbitrary ones, by using
        # iterating over the (undocumented!) OptionsStack???
        if Length(propsToCompute) = 0 then
            propsToCompute := [ "DefaultMode" ];
        fi;
    else
        if IsString(arg[2]) then
            propsToCompute := [arg[2]];
        else
            propsToCompute := arg[2];
        fi;
    fi;
    return _NmzCompute(cone, propsToCompute);
end);
