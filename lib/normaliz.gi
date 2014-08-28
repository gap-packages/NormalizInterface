##
InstallMethod( ViewString,
               "for a Normaliz cone object",
               [ IsNormalizConeObject ],
function( r )
    # TODO: May print more information when present
    return "<a Normaliz cone object>";
end );


# InstallGlobalFunction( NmzHilbertBasis,
#   function(cone)
#     return NmzConeProperty(cone, "HilbertBasis");
# end );
# 
# BindGlobal("NmzDeg1Elements", function(cone)
#     return NmzConeProperty(cone, "Deg1Elements");
# end );
# 
# BindGlobal("NmzExtremeRays", function(cone)
#     return NmzConeProperty(cone, "ExtremeRays");
# end );
# 
# BindGlobal("NmzSupportHyperplanes", function(cone)
#     return NmzConeProperty(cone, "SupportHyperplanes");
# end );
# 
# BindGlobal("NmzGrading", function(cone)
#     return NmzConeProperty(cone, "Grading");
# end );
