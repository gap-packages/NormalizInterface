##
InstallMethod( ViewString,
               "for a Normaliz cone object",
               [ IsNormalizLongIntConeObject ],
function( r )
    # TODO: May print more information when present
    return "<a Normaliz cone object with long int coefficients>";
end );

InstallMethod( ViewString,
               "for a Normaliz cone object",
               [ IsNormalizGMPConeObject ],
function( r )
    # TODO: May print more information when present
    return "<a Normaliz cone object with GMP coefficients>";
end );

InstallMethod( NmzConeProperty,
               "for a Normaliz cone and a string",
               [ IsNormalizConeObject, IsString ],
function( cone, prop )
    local result;
    result := _NmzConeProperty(cone, prop);
    return result;
end );
