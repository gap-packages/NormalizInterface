/*
 * NormalizInterface: GAP wrapper for Normaliz
 * Copyright (C) 2014  Sebastian Gutsche, Max Horn, Christof Söger
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

/*
#! @Chapter Functions
#! @Section YOU FORGOT TO SET A SECTION
*/

#include "normaliz.h"
#include "libnormaliz/map_operations.h"

#include <vector>
#include <iostream>

// Paranoia check
#ifdef SYS_IS_64_BIT
  #if GMP_LIMB_BITS != 64
    #error GAP compiled in 64 bit mode, but GMP limbs are not 64 bit
  #endif
#else
  #if GMP_LIMB_BITS != 32
    #error GAP compiled in 32 bit mode, but GMP limbs are not 32 bit
  #endif
#endif


using libnormaliz::Cone;
//using libnormaliz::ConeProperty;
using libnormaliz::ConeProperties;
using libnormaliz::Sublattice_Representation;
using libnormaliz::Type::InputType;

using std::map;
using std::vector;
using std::string;
using std::pair;

using std::cerr;
using std::endl;

Obj TheTypeNormalizCone;

UInt T_NORMALIZ = 0;

Obj NewCone(Cone<mpz_class>* C)
{
    Obj o;
    o = NewBag(T_NORMALIZ, 1 * sizeof(Obj));
    SET_CONE<mpz_class>(o, C);
    return o;
}

/* Free function */
void NormalizFreeFunc(Obj o)
{
    delete GET_CONE<mpz_class>(o);
}

/* Type object function for the object */
Obj NormalizTypeFunc(Obj o)
{
    return TheTypeNormalizCone;
}

Obj NormalizCopyFunc(Obj o, Int mut)
{
    // Cone objects are mathematically immutable, so
    // we don't need to do anything,
    return o;
}

void NormalizCleanFunc(Obj o)
{
}

Int NormalizIsMutableObjFuncs(Obj o)
{
    // Cone objects are mathematically immutable.
    return 0L;
}


static Obj MpzToGAP(const mpz_t x)
{
    Obj res;
    Int size = x->_mp_size;
    int sign;
    if (size == 0) {
        return INTOBJ_INT(0);
    } else if (size < 0) {
        size = -size;
        sign = -1;
    } else {
        sign = +1;
    }
    if (size == 1) {
        res = ObjInt_UInt(x->_mp_d[0]);
        if (sign < 0)
            res = AInvInt(res);
    } else {
        size = sizeof(mp_limb_t) * size;
        if (sign > 0)
            res = NewBag(T_INTPOS, size);
        else
            res = NewBag(T_INTNEG, size);
        memcpy(ADDR_INT(res), x->_mp_d, size);
    }
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
Obj NmzIntToGAP(libnormaliz::key_t x)   // key_t = unsigned int
{
    return ObjInt_UInt(x);
}

#ifdef SYS_IS_64_BIT
template<>
Obj NmzIntToGAP(size_t x)               // size_t = unsigned long
{
    return ObjInt_UInt(x);
}
#endif

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
            return true;
        }
    }
    return false;
}

template<>
bool GAPIntToNmz(Obj x, mpz_class &out)
{
    mpz_ptr m = out.get_mpz_t();

    if (IS_INTOBJ(x)) {
        mpz_realloc2(m, 1 * GMP_NUMB_BITS);

        if (INT_INTOBJ(x) == 0) {
            mpz_set_ui(m, 0);
        } else if (INT_INTOBJ(x) >= 0) {
            m->_mp_d[0] = INT_INTOBJ(x);
            m->_mp_size = 1;
        } else {
            m->_mp_d[0] = -INT_INTOBJ(x);
            m->_mp_size = -1;
        }

        return true;
    } else if (TNUM_OBJ(x) == T_INTPOS || TNUM_OBJ(x) == T_INTNEG) {
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
    if (!IS_PLIST(V) || !IS_DENSE_LIST(V))
        return false;
    const int n = LEN_PLIST(V);
    out.resize(n);
    for (int i = 0; i < n; ++i) {
        Obj tmp = ELM_PLIST(V, i+1);
        if (!GAPIntToNmz(tmp, out[i]))
            return false;
    }
    return true;
}

template<typename Integer>
static bool GAPIntMatrixToNmz(vector< vector<Integer> >& out, Obj M)
{
    if (!IS_PLIST(M) || !IS_DENSE_LIST(M))
        return false;
    const int nr = LEN_PLIST(M);
    out.resize(nr);
    for (int i = 0; i < nr; ++i) {
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
    for (size_t i = 0; i < n; ++i) {
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
    for (size_t i = 0; i < n; ++i) {
        SET_ELM_PLIST(M, i+1, NmzVectorToGAP(in[i]));
        CHANGED_BAG( M );
    }
    CHANGED_BAG( M );
    return M;
}

static Obj NmzHilbertSeriesToGAP(const libnormaliz::HilbertSeries& HS)
{
    Obj ret;
    ret = NEW_PLIST(T_PLIST, 3);
    SET_LEN_PLIST(ret, 3);
    AssPlist(ret, 1, NmzVectorToGAP(HS.getNum()));
    AssPlist(ret, 2, NmzVectorToGAP(libnormaliz::to_vector(HS.getDenom())));
    AssPlist(ret, 3, NmzIntToGAP(HS.getShift()));
    return ret;
}

static Obj NmzHilbertQuasiPolynomialToGAP(const libnormaliz::HilbertSeries& HS)
{
    Obj ret;
    vector< vector<mpz_class> > HQ = HS.getHilbertQuasiPolynomial();
    const size_t n = HS.getPeriod();
    ret = NEW_PLIST(T_PLIST, n+1);
    SET_LEN_PLIST(ret, n+1);

    for (size_t i = 0; i < n; ++i) {
        SET_ELM_PLIST(ret, i+1, NmzVectorToGAP(HQ[i]));
        CHANGED_BAG( ret );
    }
    AssPlist(ret, n+1, NmzIntToGAP(HS.getHilbertQuasiPolynomialDenom()));
    return ret;
}

template<typename Integer>
static Obj NmzTriangleListToGAP(const vector< pair<vector<libnormaliz::key_t>, Integer> >& in)
{
    Obj M;
    const size_t n = in.size();
    M = NEW_PLIST(T_PLIST, n);
    SET_LEN_PLIST(M, n);
    for (size_t i = 0; i < n; ++i) {
        // convert the pair
        Obj pair = NEW_PLIST(T_PLIST, 2);
        SET_LEN_PLIST(pair, 2);
        SET_ELM_PLIST(pair, 1, NmzVectorToGAP<libnormaliz::key_t>(in[i].first));
        SET_ELM_PLIST(pair, 2, NmzIntToGAP(in[i].second));
        CHANGED_BAG( pair );

        SET_ELM_PLIST(M, i+1, pair);
        CHANGED_BAG( M );
    }
    CHANGED_BAG( M );
    return M;
}


template<typename Integer>
static Obj _NmzConeIntern(Obj input_list)
{
    map <InputType, vector< vector<Integer> > > input;
    const int n = LEN_PLIST(input_list);
    if (n&1) {
        cerr << "Input list must have even number of elements" << endl;
        return Fail;
    }
    for (int i = 0; i < n; i += 2) {
        Obj type = ELM_PLIST(input_list, i+1);
        if (!IS_STRING_REP(type)) {
            cerr << "Element " << i+1 << " of the input list must be a type string" << endl;
            return Fail;
        }
        string type_str(CSTR_STRING(type));

        Obj M = ELM_PLIST(input_list, i+2);
        vector<vector<Integer> > Mat;
        bool okay = GAPIntMatrixToNmz(Mat, M);
        if (!okay) {
            cerr << "Element " << i+2 << " of the input list must integer matrix" << endl;
            return Fail;
        }

        input[libnormaliz::to_type(type_str)] = Mat;
    }

    Cone<Integer>* C = new Cone<Integer>(input);
    Obj Cone = NewCone(C);
    return Cone;

}

Obj _NmzCone(Obj self, Obj input_list)
{
    FUNC_BEGIN
    if (!IS_PLIST(input_list) || !IS_DENSE_LIST(input_list))
        ErrorQuit("Input argument must be a list", 0, 0);

    return _NmzConeIntern<mpz_class>(input_list);

    FUNC_END
}

Obj _NmzCompute(Obj self, Obj cone, Obj to_compute)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (!IS_PLIST(to_compute) || !IS_DENSE_LIST(to_compute))
        ErrorQuit("<props> must be a list of strings", 0, 0);

    ConeProperties propsToCompute;
    // we have a list
    const int n = LEN_PLIST(to_compute);

    for (int i = 0; i < n; ++i) {
        Obj prop = ELM_PLIST(to_compute, i+1);
        if (!IS_STRING_REP(prop)) {
            cerr << "Element " << i+1 << " of the input list must be a type string";
            return Fail;
        }
        string prop_str(CSTR_STRING(prop));
        propsToCompute.set( libnormaliz::toConeProperty(prop_str) );
    }

    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    ConeProperties notComputed = C->compute(propsToCompute);

    // Cone.compute returns the not computed properties
    // we return a bool, true when everything requested was computed
    return notComputed.none() ? True : False;
    FUNC_END
}


/*
#! @Section Use a NmzCone
#! @Arguments cone property
#! @Returns whether the cone has already computed the given property
#! @Description
#! See <Ref Func="NmzConeProperty"/> for a list of recognized properties.
#!
#! @InsertChunk NmzHasConeProperty example
DeclareGlobalFunction("NmzHasConeProperty");
*/
Obj NmzHasConeProperty(Obj self, Obj cone, Obj prop)
{
    FUNC_BEGIN

    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (!IS_STRING_REP(prop))
        ErrorQuit("<prop> must be a string", 0, 0);

    libnormaliz::ConeProperty::Enum p = libnormaliz::toConeProperty(CSTR_STRING(prop));

    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    return C->isComputed(p) ? True : False;

    FUNC_END
}

/*
#! @Section Use a NmzCone
#! @Arguments cone
#! @Returns a list of strings representing the known (computed) cone properties
#! @Description
#! Given a Normaliz cone object, return a list of all properties already
#! computed for the cone.
#!
#! @InsertChunk NmzKnownConeProperties example
DeclareGlobalFunction("NmzKnownConeProperties");
*/
Obj NmzKnownConeProperties(Obj self, Obj cone)
{
    FUNC_BEGIN

    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);

    size_t n = 0;
    Obj M = NEW_PLIST(T_PLIST, libnormaliz::ConeProperty::EnumSize);

    // FIXME: This code could be a lot simpler if there was
    // a Cone method for reading the value of is_Computed.
    for (int i = 0; i < libnormaliz::ConeProperty::EnumSize; ++i) {
        libnormaliz::ConeProperty::Enum p = (libnormaliz::ConeProperty::Enum)i;

        Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
        bool isComputed = C->isComputed(p);

        if (isComputed) {
            string prop_name(libnormaliz::toString(p));

            Obj prop_name_gap;
            C_NEW_STRING(prop_name_gap, prop_name.size(), prop_name.c_str());

            n++;    // Increment counter
            SET_ELM_PLIST(M, n, prop_name_gap);
            CHANGED_BAG(M);
            if (p == libnormaliz::ConeProperty::HilbertSeries) {
                Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
                C->getHilbertSeries().computeHilbertQuasiPolynomial();
                isComputed = C->getHilbertSeries().isHilbertQuasiPolynomialComputed();

                if (isComputed) {
                    string prop_name("HilbertQuasiPolynomial");

                    Obj prop_name_gap;
                    C_NEW_STRING(prop_name_gap, prop_name.size(), prop_name.c_str());

                    n++;    // Increment counter
                    SET_ELM_PLIST(M, n, prop_name_gap);
                    CHANGED_BAG(M);
                }
            }
        }
    }
    SET_LEN_PLIST(M, n);
    return M;

    FUNC_END
}

template<typename Integer>
static Obj _NmzConePropertyImpl(Obj cone, Obj prop)
{
    Cone<Integer>* C = GET_CONE<Integer>(cone);
    // there is no ConeProperty HilbertQuasiPolynomial, it is part of the HilbertSeries
    // FIXME better way?
    if (string(CSTR_STRING(prop)) == string("HilbertQuasiPolynomial")) {
        C->compute(ConeProperties(libnormaliz::ConeProperty::HilbertSeries));
        return NmzHilbertQuasiPolynomialToGAP(C->getHilbertSeries());
    }

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

    case libnormaliz::ConeProperty::Triangulation:
        return NmzTriangleListToGAP<Integer>(C->getTriangulation());

    case libnormaliz::ConeProperty::Multiplicity:
        {
        mpq_class mult = C->getMultiplicity();
        return MpqClassToGAP(mult);
        }

    case libnormaliz::ConeProperty::RecessionRank:
        return NmzIntToGAP(C->getRecessionRank());

    case libnormaliz::ConeProperty::AffineDim:
        return NmzIntToGAP(C->getAffineDim());

    case libnormaliz::ConeProperty::ModuleRank:
        return NmzIntToGAP(C->getModuleRank());

    case libnormaliz::ConeProperty::HilbertBasis:
        return NmzMatrixToGAP(C->getHilbertBasis());

    case libnormaliz::ConeProperty::MaximalSubspace:
        return NmzMatrixToGAP(C->getMaximalSubspace());

    case libnormaliz::ConeProperty::ModuleGenerators:
        return NmzMatrixToGAP(C->getModuleGenerators());

    case libnormaliz::ConeProperty::Deg1Elements:
        return NmzMatrixToGAP(C->getDeg1Elements());

    case libnormaliz::ConeProperty::HilbertSeries:
        return NmzHilbertSeriesToGAP(C->getHilbertSeries());
        break;

    case libnormaliz::ConeProperty::Grading:
        {
        vector<Integer> grad = C->getGrading();
        grad.push_back(C->getGradingDenom());
        return NmzVectorToGAP(grad);
        }

    case libnormaliz::ConeProperty::IsPointed:
        return C->isPointed() ? True : False;

    case libnormaliz::ConeProperty::IsDeg1ExtremeRays:
        return C->isDeg1ExtremeRays() ? True : False;

    case libnormaliz::ConeProperty::IsDeg1HilbertBasis:
        return C->isDeg1HilbertBasis() ? True : False;

    case libnormaliz::ConeProperty::IsIntegrallyClosed:
        return C->isIntegrallyClosed() ? True : False;

    case libnormaliz::ConeProperty::OriginalMonoidGenerators:
        return NmzMatrixToGAP(C->getOriginalMonoidGenerators());

    case libnormaliz::ConeProperty::IsReesPrimary:
        return C->isReesPrimary() ? True : False;

    case libnormaliz::ConeProperty::ReesPrimaryMultiplicity:
        return NmzIntToGAP(C->getReesPrimaryMultiplicity());

    // StanleyDec is special and we do not support the required conversion at
    // this time. If you really need this, contact the developers.
    case libnormaliz::ConeProperty::StanleyDec:
        //C->getStanleyDec();
        break;

    case libnormaliz::ConeProperty::ExcludedFaces:
        return NmzMatrixToGAP(C->getExcludedFaces());

    case libnormaliz::ConeProperty::Dehomogenization:
        return NmzVectorToGAP(C->getDehomogenization());

    case libnormaliz::ConeProperty::InclusionExclusionData:
        return NmzTriangleListToGAP<long>(C->getInclusionExclusionData());

    case libnormaliz::ConeProperty::ClassGroup:
        return NmzVectorToGAP(C->getClassGroup());

    case libnormaliz::ConeProperty::Sublattice:
        C->compute(p);
        return C->isComputed(p) ? True : False;

//  the following properties are compute options and do not return anything
    case libnormaliz::ConeProperty::DualMode:
    case libnormaliz::ConeProperty::DefaultMode:
    case libnormaliz::ConeProperty::Approximate:
    case libnormaliz::ConeProperty::BottomDecomposition:
    case libnormaliz::ConeProperty::KeepOrder:
        return True;    // FIXME: appropriate value?

    default:
        // Case not handled. Should signal an error
        break;
    }

    return Fail;
}

Obj _NmzConeProperty(Obj self, Obj cone, Obj prop)
{
    FUNC_BEGIN

    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (!IS_STRING_REP(prop))
        ErrorQuit("<prop> must be a string", 0, 0);

    return _NmzConePropertyImpl<mpz_class>(cone, prop);

    FUNC_END
}



/*
#! @Section Use a NmzCone
#! @Arguments verboseFlag
#! @Returns the previous verbosity
#! @Description
#! Set the global default verbosity state in libnormaliz.
#! This will influence all NmzCone created afterwards, but not any existing ones.
#!
#! See also <Ref Func="NmzSetVerbose"/>
DeclareGlobalFunction("NmzSetVerboseDefault");
*/
Obj NmzSetVerboseDefault(Obj self, Obj value)
{
    FUNC_BEGIN
    if (value != True && value != False)
        ErrorQuit("<value> must be a boolean value", 0, 0);
    return libnormaliz::setVerboseDefault(value == True) ? True : False;
    FUNC_END
}
/*
#! @Arguments cone verboseFlag
#! @Returns the previous verbosity
#! @Description
#! Set the verbosity state for a cone.
#!
#! See also <Ref Func="NmzSetVerboseDefault"/>
DeclareGlobalFunction("NmzSetVerbose");
*/
Obj NmzSetVerbose(Obj self, Obj cone, Obj value)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (value != True && value != False)
        ErrorQuit("<value> must be a boolean value", 0, 0);
    bool old_value;

    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    old_value = C->setVerbose(value == True);
    return old_value ? True : False;
    FUNC_END
}

/*
#! @Section Cone properties
*/

/*
#! @Arguments cone
#! @Returns the embedding dimension of the cone
#! @Description
#! The embedding dimension is the dimension of the space in which the
#! computation is done. It is the number of components of the output vectors.
#! This value is always known directly after the creation of the cone.
DeclareGlobalFunction("NmzEmbeddingDimension");
*/
Obj NmzEmbeddingDimension(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    return NmzIntToGAP(C->getEmbeddingDim());
    FUNC_END
}

template<typename Integer>
static Obj _NmzBasisChangeIntern(Obj cone)
{
    Cone<Integer>* C = GET_CONE<Integer>(cone);
    Sublattice_Representation<Integer> bc = C->getSublattice();

    Obj res = NEW_PLIST(T_PLIST, 3);
    SET_LEN_PLIST(res, 3);
    AssPlist(res, 1, NmzMatrixToGAP(bc.getEmbedding()));
    AssPlist(res, 2, NmzMatrixToGAP(bc.getProjection()));
    AssPlist(res, 3, NmzIntToGAP(bc.getAnnihilator()));
    // Dim, Rank, Equations and Congruences are already covered by special functions
    // The index is not always computed and not so relevant
    return res;
}

Obj _NmzBasisChange(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    return _NmzBasisChangeIntern<mpz_class>(cone);
    FUNC_END
}

/*
#! @Arguments cone
#! @Returns the rank of the cone
#! @Description
#! The rank is the rank of the lattice generated by the lattice points of the cone.
#! <P/>
#! This is part of the cone property <Q>Sublattice</Q>.
DeclareGlobalFunction("NmzRank");
*/
Obj NmzRank(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    return NmzIntToGAP(C->getSublattice().getRank());
    FUNC_END
}

/*
#! @Arguments cone
#! @Returns whether the cone is inhomogeneous
#! @Description
#! This value is always known directly after the creation of the cone.
DeclareGlobalFunction("NmzIsInhomogeneous");
*/
Obj NmzIsInhomogeneous(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    return C->isInhomogeneous() ? True : False;
    FUNC_END
}

/*
#! @Arguments cone
#! @Returns a matrix whose rows represent the equations
#! @Description
#! The equations cut out the linear space generated by the cone.
#! Together with the support hyperplanes and the congruences it describes the
#! lattice points of the cone.
#! <P/>
#! This is part of the cone property <Q>Sublattice</Q>.
DeclareGlobalFunction("NmzEquations");
*/
Obj NmzEquations(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::SupportHyperplanes));
    return NmzMatrixToGAP(C->getSublattice().getEquations());
    FUNC_END
}


/*
#! @Arguments cone
#! @Returns a matrix whose rows represent the congruences
#! @Description
#! Together with the support hyperplanes and the equations it describes the
#! lattice points of the cone.
#! <P/>
#! This is part of the cone property <Q>Sublattice</Q>.
DeclareGlobalFunction("NmzCongruences");
*/
Obj NmzCongruences(Obj self, Obj cone)
{
    FUNC_BEGIN
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    C->compute(ConeProperties(libnormaliz::ConeProperty::SupportHyperplanes));
    return NmzMatrixToGAP(C->getSublattice().getCongruences());
    FUNC_END
}


typedef Obj (* GVarFuncType)(/*arguments*/);

#define GVAR_FUNC_TABLE_ENTRY(srcfile, name, nparam, params) \
  {#name, nparam, \
   params, \
   (GVarFuncType)name, \
   srcfile ":Func" #name }

// Table of functions to export
static StructGVarFunc GVarFuncs[] = {
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", _NmzCone, 1, "list"),

    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", _NmzCompute, 2, "cone, props"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzSetVerboseDefault, 1, "value"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzSetVerbose, 2, "cone, value"),

    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzHasConeProperty, 2, "cone, prop"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", _NmzConeProperty, 2, "cone, prop"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzKnownConeProperties, 1, "cone"),

    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzEmbeddingDimension, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", _NmzBasisChange, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzRank, 1, "cone"),
    GVAR_FUNC_TABLE_ENTRY("normaliz.cc", NmzIsInhomogeneous, 1, "cone"),
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

#if 1
    // GAP >= 4.8:
    T_NORMALIZ = RegisterPackageTNUM("NormalizCone", NormalizTypeFunc);
#else
    // GAP < 4.8:
    T_NORMALIZ = T_SPARE1;  // HACK
    InfoBags[T_NORMALIZ].name = "NormalizCone";
    TypeObjFuncs[T_NORMALIZ] = &NormalizTypeFunc;
#endif
    InitMarkFuncBags(T_NORMALIZ, &MarkNoSubBags);
    InitFreeFuncBag(T_NORMALIZ, &NormalizFreeFunc);

    CopyObjFuncs[ T_NORMALIZ ] = &NormalizCopyFunc;
    CleanObjFuncs[ T_NORMALIZ ] = &NormalizCleanFunc;
    IsMutableObjFuncs[ T_NORMALIZ ] = &NormalizIsMutableObjFuncs;

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
#ifdef NORMALIZSTATIC
 /* type        = */ MODULE_STATIC,
#else
 /* type        = */ MODULE_DYNAMIC,
#endif
 /* name        = */ "Normaliz",
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

#ifndef NORMALIZSTATIC
extern "C"
StructInitInfo * Init__Dynamic ( void )
{
  return &module;
}
#endif

extern "C"
StructInitInfo * Init__normaliz ( void )
{
    return &module;
}
