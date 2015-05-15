##
InstallMethod( ViewString,
               "for a Normaliz cone",
               [ IsNormalizLongIntCone ],
function( r )
    # TODO: May print more information when present
    return "<a Normaliz cone with long int coefficients>";
end );

InstallMethod( ViewString,
               "for a Normaliz cone",
               [ IsNormalizGMPCone ],
function( r )
    # TODO: May print more information when present
    return "<a Normaliz cone with GMP coefficients>";
end );

InstallMethod( NmzConeProperty,
               "for a Normaliz cone and a string",
               [ IsNormalizCone, IsString ],
function( cone, prop )
    local result, t, poly, tmp, denom;
    result := _NmzConeProperty(cone, prop);
    if prop = "Grading" then
        tmp := Length(result);
        denom := result[tmp];
        result := result{[1..(tmp-1)]};
        return result / denom;
    fi;
    if prop = "HilbertSeries" then
        t := Indeterminate(Integers, "t");
        poly := UnivariatePolynomial(Integers, result[1], t);
        tmp := Collected(result[2]);
        return [poly, tmp];
    fi;
    if prop = "HilbertFunction" then
        t := Indeterminate(Rationals, "t");
        denom := Remove(result);
        poly := List(result, coeffs -> UnivariatePolynomial(Rationals, coeffs, t));
        return poly / denom;
    fi;
    return result;
end );

InstallMethod( NmzBasisChange,
               "for a Normaliz cone",
               [ IsNormalizCone ],
function( cone )
    local result;
    result := _NmzBasisChange(cone);
    return rec(
        dim := result[1],
        rank := result[2],
        index := result[3],
        A := result[4],
        B := result[5],
        c := result[6],
        );
end );


