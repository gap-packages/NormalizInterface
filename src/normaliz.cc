/*
 * GAPnormaliz: GAP wrapper for normaliz
 * Copyright (C) 2014  TODO
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#include "normaliz.h"

#include <vector>
#include <iostream>

using libnormaliz::Cone;
//using libnormaliz::ConeProperty;
using libnormaliz::ConeProperties;
using libnormaliz::Type::InputType;

using std::map;
using std::vector;
using std::string;

using std::cerr;
using std::endl;

Obj TheTypeNormalizCone;



Obj NewCone(Cone<long>* C) {
  Obj o;
  o = NewBag(T_NORMALIZ, 2*sizeof(Obj));

  ADDR_OBJ(o)[0] = TheTypeNormalizCone;
  SET_CONE(o, C);
  return o;
}

/* Free function */
void NormalizFreeFunc(Obj o) {
  Cone<long>* C = GET_CONE(o);
  if(C != NULL)
    delete C;
}

/* Type object function for the object */
Obj NormalizTypeFunc(Obj o) {
  return ADDR_OBJ(o)[0];
}


Obj NormalizTest(Obj self, Obj A)
{
    // we just return our parameter
    return A;
}

bool GAPIntVectorToNmz(vector<long>& out, Obj V)
{
    if (!IS_DENSE_PLIST(V))
        return false;
    const int n = LEN_PLIST(V);
    out.resize(n);
    for (int i=0; i < n; ++i)
    {
        Obj tmp = ELM_PLIST(V, i+1);
        if (!IS_INTOBJ(tmp))
            return false;
        out[i] = INT_INTOBJ(tmp);
    }
    return true;
}

bool GAPIntMatrixToNmz(vector< vector<long> >& out, Obj M)
{
    if (!IS_DENSE_PLIST(M))
        return false;
    const int nr = LEN_PLIST(M);
    out.resize(nr);
    for (int i=0; i < nr; ++i)
    {
        bool okay = GAPIntVectorToNmz(out[i], ELM_PLIST(M, i+1));
        if (!okay)
            return false;
    }
    return true;
}

Obj NmzVectorToGAP(const vector<long>& in)
{
    Obj M;
    const size_t n = in.size();
    M = NEW_PLIST(T_PLIST_CYC, n);
    SET_LEN_PLIST(M, n);
    for (size_t i=0; i < n; ++i)
    {
        SET_ELM_PLIST(M, i+1, ObjInt_Int(in[i]));
        CHANGED_BAG( M );
    }
    return M;
}

Obj NmzMatrixToGAP(const vector< vector<long> >& in)
{
    Obj M;
    const size_t n = in.size();
    M = NEW_PLIST(T_PLIST_CYC, n);
    SET_LEN_PLIST(M, n);
    for (size_t i=0; i < n; ++i)
    {
        SET_ELM_PLIST(M, i+1, NmzVectorToGAP(in[i]));
        CHANGED_BAG( M );
    }
    CHANGED_BAG( M );
    return M;
}


Obj NormalizCone(Obj self, Obj input_list)
{
    FUNC_BEGIN
    if (!IS_DENSE_PLIST(input_list))
        ErrorQuit("Input argument must be a list",0,0);

    map <InputType, vector< vector<long> > > input;
    const int n = LEN_PLIST(input_list);
    if (n&1)
    {
        cerr << "Input list must have even number of elements" << endl;
        return Fail;
    }
    for (int i=0; i < n; i+=2)
    {
        Obj type = ELM_PLIST(input_list, i+1);
        if (!IS_STRING_REP(type))
        {
            cerr << "Element " << i+1 << " of the input list must be a type string" << endl;
            return Fail;
        }
        string type_str(CSTR_STRING(type));

        Obj M = ELM_PLIST(input_list, i+2);
        vector<vector<long> > Mat;
        bool okay = GAPIntMatrixToNmz(Mat, M);
        if (!okay)
        {
            cerr << "Element " << i+2 << " of the input list must integer matrix" << endl;
            return Fail;
        }

        input[libnormaliz::to_type(type_str)] = Mat;
    }

    Cone<long>* C = new Cone<long>(input);
    Obj Cone = NewCone(C);
    return Cone;

    FUNC_END
}

Obj NmzCompute(Obj self, Obj cone, Obj compute_list)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("Input argument 1 must be a cone",0,0);
    if (!IS_DENSE_PLIST(compute_list))
        ErrorQuit("Input argument 2 must be a list",0,0);

    ConeProperties Props;

    const int n = LEN_PLIST(compute_list);

    for (int i=0; i < n; ++i)
    {
        Obj prop = ELM_PLIST(compute_list, i+1);
        if (!IS_STRING_REP(prop))
        {
            cerr << "Element " << i+1 << " of the input list must be a type string";
            return Fail;
        }
        string prop_str(CSTR_STRING(prop));
        Props.set( libnormaliz::toConeProperty(prop_str) );
    }

    Cone<long>* C = GET_CONE(cone);

    // Cone.compute returns the not computed properties
    // we return a bool, true when everything requested was computed
    ConeProperties NotComputed = C->compute(Props);
// TODO this gives: "Error, <expr> must be 'true' or 'false' (not a integer)"
//      but .none() returns bool
//    return EVAL_BOOL_EXPR( NotComputed.none() );
    return (NotComputed.none() ? True : False );
    FUNC_END
}


Obj NmzHilbertBasis(Obj self, Obj cone)
{
    FUNC_BEGIN
    if(!IS_CONE(cone))
        ErrorQuit("Input must be a cone",0,0);
    Cone<long>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::HilbertBasis));
    return NmzMatrixToGAP(C->getHilbertBasis());
    FUNC_END
}

Obj NmzDeg1Elements(Obj self, Obj cone)
{
    FUNC_BEGIN
    if(!IS_CONE(cone))
        ErrorQuit("Input must be a cone",0,0);
    Cone<long>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::Deg1Elements));
    return NmzMatrixToGAP(C->getDeg1Elements());
    FUNC_END
}

Obj NmzExtremeRays(Obj self, Obj cone)
{
    FUNC_BEGIN
    if(!IS_CONE(cone))
        ErrorQuit("Input must be a cone",0,0);
    Cone<long>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::ExtremeRays));
    return NmzMatrixToGAP(C->getExtremeRays());
    FUNC_END
}

Obj NmzSupportHyperplanes(Obj self, Obj cone)
{
    FUNC_BEGIN
    if(!IS_CONE(cone))
        ErrorQuit("Input must be a cone",0,0);
    Cone<long>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::SupportHyperplanes));
    return NmzMatrixToGAP(C->getSupportHyperplanes());
    FUNC_END
}

Obj NmzEquations(Obj self, Obj cone)
{
    FUNC_BEGIN
    if(!IS_CONE(cone))
        ErrorQuit("Input must be a cone",0,0);
    Cone<long>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::SupportHyperplanes));
    return NmzMatrixToGAP(C->getEquations());
    FUNC_END
}

Obj NmzCongruences(Obj self, Obj cone)
{
    FUNC_BEGIN
    if(!IS_CONE(cone))
        ErrorQuit("Input must be a cone",0,0);
    Cone<long>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::SupportHyperplanes));
    libnormaliz::Matrix<long> Cong = C->getCongruencesMatrix();
    Cong.pretty_print(cerr);
    return NmzMatrixToGAP(C->getCongruences());
    FUNC_END
}

Obj NmzGrading(Obj self, Obj cone)
{
    FUNC_BEGIN
    if(!IS_CONE(cone))
        ErrorQuit("Input must be a cone",0,0);
    Cone<long>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::Grading));
    return NmzVectorToGAP(C->getGrading());
    FUNC_END
}


typedef Obj (* GVarFunc)(/*arguments*/);

#define GVAR_FUNC_TABLE_ENTRY(srcfile, name, nparam, params) \
  {#name, nparam, \
   params, \
   (GVarFunc)name, \
   srcfile ":Func" #name }

// Table of functions to export
static StructGVarFunc GVarFuncs [] = {
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NormalizTest, 1, "xyz"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NormalizCone, 1, "list"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzCompute, 2, "Cone, list"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzHilbertBasis, 1, "Cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzDeg1Elements, 1, "Cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzExtremeRays, 1, "Cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzSupportHyperplanes, 1, "Cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzEquations, 1, "Cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzCongruences, 1, "Cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzGrading, 1, "Cone"),

	{ 0 } /* Finish with an empty entry */

};

/******************************************************************************
*F  InitKernel( <module> )  . . . . . . . . initialise kernel data structures
*/
static Int InitKernel( StructInitInfo *module )
{
    /* init filters and functions                                          */
    InitHdlrFuncsFromTable( GVarFuncs );

    InitCopyGVar( "TheTypeNormalizCone", &TheTypeNormalizCone );
       
    InfoBags[T_NORMALIZ].name = "NormalizCone";
    InitMarkFuncBags(T_NORMALIZ, &MarkOneSubBags);
    InitFreeFuncBag(T_NORMALIZ, &NormalizFreeFunc);
    TypeObjFuncs[T_NORMALIZ] = &NormalizTypeFunc;

    

    /* return success                                                      */
    return 0;
}

/******************************************************************************
*F  InitLibrary( <module> ) . . . . . . .  initialise library data structures
*/
static Int InitLibrary( StructInitInfo *module )
{
    /* init filters and functions */
    InitGVarFuncsFromTable( GVarFuncs );

    /* return success                                                      */
    return 0;
}

/******************************************************************************
*F  InitInfopl()  . . . . . . . . . . . . . . . . . table of init functions
*/
static StructInitInfo module = {
#ifdef PCQLSTATIC
 /* type        = */ MODULE_STATIC,
#else
 /* type        = */ MODULE_DYNAMIC,
#endif
 /* name        = */ "pcql",
 /* revision_c  = */ 0,
 /* revision_h  = */ 0,
 /* version     = */ 0,
 /* crc         = */ 0,
 /* initKernel  = */ InitKernel,
 /* initLibrary = */ InitLibrary,
 /* checkInit   = */ 0,
 /* preSave     = */ 0,
 /* postSave    = */ 0,
 /* postRestore = */ 0
};

#ifndef PCQLSTATIC
extern "C"
StructInitInfo * Init__Dynamic ( void )
{
  return &module;
}
#endif

extern "C"
StructInitInfo * Init__pcql ( void )
{
  return &module;
}
