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
    local result, poly, tmp;
    result := _NmzConeProperty(cone, prop);
    if prop = "HilbertSeries" then
        poly := UnivariatePolynomial(Integers, result[1], Indeterminate(Integers, "t"));
        tmp := Collected(result[2]);
        return [poly, tmp];
    fi;
    return result;
end );
