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
    local result;
    result := _NmzConeProperty(cone, prop);
    return result;
end );
