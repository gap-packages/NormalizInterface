/*
 * NormalizInterface: GAP wrapper for normaliz
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
using libnormaliz::Sublattice_Representation;
using libnormaliz::Type::InputType;

using std::map;
using std::vector;
using std::string;

using std::cerr;
using std::endl;

Obj TheTypeNormalizCone;



Obj NewCone(Cone<NMZ_INTEGER_TYPE>* C) {
    Obj o;
    o = NewBag(T_NORMALIZ, 2*sizeof(Obj));

    ADDR_OBJ(o)[0] = TheTypeNormalizCone;
    SET_CONE(o, C);
    return o;
}

/* Free function */
void NormalizFreeFunc(Obj o) {
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(o);
    if(C != NULL)
        delete C;
}

/* Type object function for the object */
Obj NormalizTypeFunc(Obj o) {
    return ADDR_OBJ(o)[0];
}

static Obj MpzToGAP(const mpz_t x)
{
    Obj res;
    Int size = x->_mp_size;
    int sign;
    if (size < 0) {
        size = -size;
        sign = -1;
    } else {
        sign = +1;
    }
#ifdef SYS_IS_64_BIT
    if (size == 1) {
        if (sign > 0)
            return ObjInt_UInt(x->_mp_d[0]);
        else
            return AInvInt(ObjInt_UInt(x->_mp_d[0]));
    }
#endif
    size = sizeof(mp_limb_t) * size;
    if (sign > 0)
        res = NewBag(T_INTPOS, size);
    else
        res = NewBag(T_INTNEG, size);
    memcpy(ADDR_INT(res), x->_mp_d, size);
    return res;
}

static inline Obj MpzClassToGAP(const mpz_class& x)
{
    return MpzToGAP(x.get_mpz_t());
}

static Obj MpqClassToGAP(const mpq_class& x)
{
    Obj num = MpzClassToGAP(x.get_num());
    Obj den = MpzClassToGAP(x.get_den());
    return QUO(num, den);
}

template<typename Integer>
Obj NmzIntToGAP(Integer x)
{
    return Integer::unimplemented_function;
}

template<>
Obj NmzIntToGAP(size_t x)
{
    return ObjInt_UInt(x);
}

template<>
Obj NmzIntToGAP(long x)
{
    return ObjInt_Int(x);
}

template<>
Obj NmzIntToGAP(mpz_class x)
{
    return MpzClassToGAP(x);
}



template<typename Integer>
bool GAPIntToNmz(Obj x, Integer &out)
{
    return Integer::unimplemented_function;
}

template<>
bool GAPIntToNmz(Obj x, long &out)
{
    if (IS_INTOBJ(x)) {
        out = INT_INTOBJ(x);
        return true;
    } else if (TNUM_OBJ(x) == T_INTPOS || TNUM_OBJ(x) == T_INTNEG) {
        UInt size = SIZE_INT(x);
        if (size == 1) {
            out = *ADDR_INT(x);
            if (out < 0)
                return false;   // overflow
            if (TNUM_OBJ(x) == T_INTNEG)
                out = -out;
        }
    }
    return false;
}

template<>
bool GAPIntToNmz(Obj x, mpz_class &out)
{
    if (IS_INTOBJ(x)) {
        out = (int)INT_INTOBJ(x);
        return true;
    } else if (TNUM_OBJ(x) == T_INTPOS || TNUM_OBJ(x) == T_INTNEG) {
        mpz_ptr m = out.get_mpz_t();
        UInt size = SIZE_INT(x);
        mpz_realloc2(m, size * GMP_NUMB_BITS);
        memcpy(m->_mp_d, ADDR_INT(x), sizeof(mp_limb_t) * size);
        m->_mp_size = (TNUM_OBJ(x) == T_INTPOS) ? (Int)size : - (Int)size;
        return true;
    }
    return false;
}

template<typename Integer>
static bool GAPIntVectorToNmz(vector<Integer>& out, Obj V)
{
    if (!IS_DENSE_PLIST(V))
        return false;
    const int n = LEN_PLIST(V);
    out.resize(n);
    for (int i=0; i < n; ++i)
    {
        Obj tmp = ELM_PLIST(V, i+1);
        if (!GAPIntToNmz(tmp, out[i]))
            return false;
    }
    return true;
}

template<typename Integer>
static bool GAPIntMatrixToNmz(vector< vector<Integer> >& out, Obj M)
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

template<typename Integer>
static Obj NmzVectorToGAP(const vector<Integer>& in)
{
    Obj M;
    const size_t n = in.size();
    M = NEW_PLIST((n > 0) ? T_PLIST_CYC : T_PLIST, n);
    SET_LEN_PLIST(M, n);
    for (size_t i=0; i < n; ++i)
    {
        SET_ELM_PLIST(M, i+1, NmzIntToGAP(in[i]));
        CHANGED_BAG( M );
    }
    return M;
}

template<typename Integer>
static Obj NmzMatrixToGAP(const vector< vector<Integer> >& in)
{
    Obj M;
    const size_t n = in.size();
    M = NEW_PLIST(T_PLIST, n);
    SET_LEN_PLIST(M, n);
    for (size_t i=0; i < n; ++i)
    {
        SET_ELM_PLIST(M, i+1, NmzVectorToGAP(in[i]));
        CHANGED_BAG( M );
    }
    CHANGED_BAG( M );
    return M;
}


Obj NmzCone(Obj self, Obj input_list)
{
    FUNC_BEGIN
    if (!IS_DENSE_PLIST(input_list))
        ErrorQuit("Input argument must be a list",0,0);

    map <InputType, vector< vector<NMZ_INTEGER_TYPE> > > input;
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
        vector<vector<NMZ_INTEGER_TYPE> > Mat;
        bool okay = GAPIntMatrixToNmz(Mat, M);
        if (!okay)
        {
            cerr << "Element " << i+2 << " of the input list must integer matrix" << endl;
            return Fail;
        }

        input[libnormaliz::to_type(type_str)] = Mat;
    }

    Cone<NMZ_INTEGER_TYPE>* C = new Cone<NMZ_INTEGER_TYPE>(input);
    Obj Cone = NewCone(C);
    return Cone;

    FUNC_END
}

Obj NmzCompute(Obj self, Obj cone, Obj compute_list)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    if (!IS_DENSE_PLIST(compute_list))
        ErrorQuit("<list> must be a list of strings",0,0);

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

    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);

    // Cone.compute returns the not computed properties
    // we return a bool, true when everything requested was computed
    ConeProperties notComputed = C->compute(Props);
    return (notComputed.none() ? True : False );
    FUNC_END
}

Obj NmzHasConeProperty(Obj self, Obj cone, Obj prop)
{
    FUNC_BEGIN

    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    if (!IS_STRING_REP(prop))
        ErrorQuit("<prop> must be a string",0,0);

    libnormaliz::ConeProperty::Enum p = libnormaliz::toConeProperty(CSTR_STRING(prop));
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);

    return (C->isComputed(p) ? True : False );

    FUNC_END
}

Obj NmzConeProperty(Obj self, Obj cone, Obj prop)
{
    FUNC_BEGIN

    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    if (!IS_STRING_REP(prop))
        ErrorQuit("<prop> must be a string",0,0);

    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    libnormaliz::ConeProperty::Enum p = libnormaliz::toConeProperty(CSTR_STRING(prop));

    ConeProperties notComputed = C->compute(ConeProperties(p));
    if (notComputed.any()) {
        return Fail;
    }

    switch (p) {
    case libnormaliz::ConeProperty::Generators:
        return NmzMatrixToGAP(C->getGenerators());

    case libnormaliz::ConeProperty::ExtremeRays:
        return NmzMatrixToGAP(C->getExtremeRays());

    case libnormaliz::ConeProperty::VerticesOfPolyhedron:
        return NmzMatrixToGAP(C->getVerticesOfPolyhedron());

    case libnormaliz::ConeProperty::SupportHyperplanes:
        return NmzMatrixToGAP(C->getSupportHyperplanes());

    case libnormaliz::ConeProperty::TriangulationSize:
        return ObjInt_UInt(C->getTriangulationSize());

    case libnormaliz::ConeProperty::TriangulationDetSum:
        return NmzIntToGAP(C->getTriangulationDetSum());

//     case libnormaliz::ConeProperty::Triangulation:
//         C->getTriangulation();   // TODO: implement conversion?
//         break;

    case libnormaliz::ConeProperty::Multiplicity:
        {
        mpq_class mult = C->getMultiplicity();
        return MpqClassToGAP(mult);
        }

    case libnormaliz::ConeProperty::Shift:
        return NmzIntToGAP(C->getShift());

    case libnormaliz::ConeProperty::ModuleRank:
        return NmzIntToGAP(C->getModuleRank());

    case libnormaliz::ConeProperty::HilbertBasis:
        return NmzMatrixToGAP(C->getHilbertBasis());

    case libnormaliz::ConeProperty::ModuleGenerators:
        return NmzMatrixToGAP(C->getModuleGenerators());

    case libnormaliz::ConeProperty::Deg1Elements:
        return NmzMatrixToGAP(C->getDeg1Elements());

//     case libnormaliz::ConeProperty::HilbertSeries:
//         C->getHilbertSeries();   // TODO: implement conversion?
//         break;

    case libnormaliz::ConeProperty::Grading:
        return NmzVectorToGAP(C->getGrading());

    case libnormaliz::ConeProperty::IsPointed:
        return C->isPointed() ? True : False;

//     case libnormaliz::ConeProperty::IsDeg1Generated:
//         TODO: Is this needed? No accessor function seems to exist

    case libnormaliz::ConeProperty::IsDeg1ExtremeRays:
        return C->isDeg1ExtremeRays() ? True : False;

    case libnormaliz::ConeProperty::IsDeg1HilbertBasis:
        return C->isDeg1HilbertBasis() ? True : False;

    case libnormaliz::ConeProperty::IsIntegrallyClosed:
        return C->isIntegrallyClosed() ? True : False;

     case libnormaliz::ConeProperty::GeneratorsOfToricRing:
         return NmzMatrixToGAP(C->getGeneratorsOfToricRing());

//     case libnormaliz::ConeProperty::ReesPrimary:
//         TODO: Is this needed? No accessor function seems to exist

    case libnormaliz::ConeProperty::ReesPrimaryMultiplicity:
        return NmzIntToGAP(C->getReesPrimaryMultiplicity());

//     case libnormaliz::ConeProperty::StanleyDec:
//         C->getStanleyDec();  // TODO: implement conversion?
//         break;

//     case libnormaliz::ConeProperty::InclusionExclusionData:
//         C->getInclusionExclusionData();  // TODO: implement conversion?
//         break;

//     case libnormaliz::ConeProperty::DualMode:
//         TODO: Is this needed? No accessor function seems to exist

//     case libnormaliz::ConeProperty::ApproximateRatPolytope:
//         TODO: Is this needed? No accessor function seems to exist

//     case libnormaliz::ConeProperty::DefaultMode:
//         TODO: Is this needed? No accessor function seems to exist

    default:
        // Case not handled. Should signal an error
        break;
    }

    return Fail;

    FUNC_END
}

Obj NmzDimension(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    return NmzIntToGAP(C->getDim());
    FUNC_END
}

Obj NmzBasisChange(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    Sublattice_Representation<NMZ_INTEGER_TYPE> bc = C->getBasisChange();
    
    // TODO: return a record instead of an array. For now,
    // we use an array because it is simpler.
    Obj res = NEW_PLIST(T_PLIST, 6);
    SET_LEN_PLIST(res, 6);
    AssPlist(res, 1, NmzIntToGAP(bc.get_dim()));
    AssPlist(res, 2, NmzIntToGAP(bc.get_rank()));
    AssPlist(res, 3, NmzIntToGAP(bc.get_index()));
    AssPlist(res, 4, NmzMatrixToGAP(bc.get_A().get_elements()));
    AssPlist(res, 5, NmzMatrixToGAP(bc.get_B().get_elements()));
    AssPlist(res, 6, NmzIntToGAP(bc.get_c()));
    // bc.get_congruences() is already covered by NmzCongruences
    return res;
    FUNC_END
}

// TODO: Do we want this?
Obj NmzBasisChangeRank(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    return NmzIntToGAP(C->getBasisChange().get_rank());
    FUNC_END
}

// TODO: Do we want this?
Obj NmzBasisChangeIndex(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    return NmzIntToGAP(C->getBasisChange().get_index());
    FUNC_END
}

Obj NmzGradingDenom(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::Grading));
    return NmzIntToGAP(C->getGradingDenom());
    FUNC_END
}

Obj NmzIsInhomogeneous(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    return C->isInhomogeneous() ? True : False;
    FUNC_END
}

Obj NmzIsReesPrimary(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    return C->isReesPrimary() ? True : False;
    FUNC_END
}

Obj NmzEquations(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::SupportHyperplanes));
    return NmzMatrixToGAP(C->getEquations());
    FUNC_END
}

Obj NmzCongruences(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a normaliz cone",0,0);
    Cone<NMZ_INTEGER_TYPE>* C = GET_CONE(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::SupportHyperplanes));
    libnormaliz::Matrix<NMZ_INTEGER_TYPE> Cong = C->getCongruencesMatrix();
    Cong.pretty_print(cerr);
    return NmzMatrixToGAP(C->getCongruences());
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
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzCone, 1, "list"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzCompute, 2, "cone, list"),

    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzHasConeProperty, 2, "cone, prop"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzConeProperty, 2, "cone, prop"),

    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzDimension, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzBasisChange, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzBasisChangeRank, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzBasisChangeIndex, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzGradingDenom, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzIsInhomogeneous, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzIsReesPrimary, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzEquations, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzCongruences, 1, "cone"),

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
