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
#include "libnormaliz/cone.h"

#include <vector>
#include <iostream>

using libnormaliz::Cone;
//using libnormaliz::ConeProperty;
using libnormaliz::ConeProperties;
using libnormaliz::Type::InputType;

using std::map;
using std::vector;

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
    return M;
}


Obj NormalizTestCone(Obj self, Obj M)
{
/*    long M[5][3] = {{2, 0, 0},
                    {1, 3, 1},
                    {3, 3, 1},
                    {0, 0, 2},
                    {1,-3, 1}};

    vector<long> row;
    vector<vector<long> > Gens;
    for (long i=0; i<5; ++i) {
        row.assign(M[i], (M[i]) + 3);
        Gens.push_back(row);
    }
*/

    vector<vector<long> > Gens;
    bool okay = GAPIntMatrixToNmz(Gens, M);
    if (!okay)
        return Fail;

    map <InputType, vector< vector<long> > > input;
    input[libnormaliz::Type::integral_closure] = Gens;
    Cone<long> MyCone(input);

//    MyCone.compute(libnormaliz::ConeProperty::HilbertBasis);
    MyCone.compute(ConeProperties(libnormaliz::ConeProperty::HilbertBasis));
    return NmzMatrixToGAP(MyCone.getHilbertBasis());
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
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NormalizTestCone, 1, "Mat"),

	{ 0 } /* Finish with an empty entry */

};

/******************************************************************************
*F  InitKernel( <module> )  . . . . . . . . initialise kernel data structures
*/
static Int InitKernel( StructInitInfo *module )
{
    /* init filters and functions                                          */
    InitHdlrFuncsFromTable( GVarFuncs );

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
