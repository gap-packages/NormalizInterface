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
