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
