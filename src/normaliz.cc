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

#include <gmp.h>

extern "C" {
#include "src/compiled.h"          /* GAP headers                */
}
#include "libnormaliz/cone.h"
#include <assert.h>


#include "libnormaliz/map_operations.h"

#include <vector>
#include <iostream>

#include <csignal>
using std::signal;

typedef void (*sighandler_t)(int);

// the TNUM used for NormalizInterface objects,
extern UInt T_NORMALIZ;

// old versions of libnormaliz (before 2.99.1) did not include such a define
#if !defined(NMZ_RELEASE) || NMZ_RELEASE < 30400
#error Your Normaliz version is to old! Update to 3.4.0 or newer.
#endif

#define FUNC_BEGIN try {

#define FUNC_END \
    } catch (std::exception& e) { \
        ErrorQuit(e.what(),0,0); \
        return Fail; \
    } catch (const char* a) { \
        ErrorQuit(a,0,0); \
        return Fail; \
    }

#define SIGNAL_HANDLER_BEGIN \
    sighandler_t current_interpreter_sigint_handler = signal( SIGINT, signal_handler ); \
    try{

#define SIGNAL_HANDLER_END \
    } catch (libnormaliz::InterruptException& e ) {\
        signal(SIGINT,current_interpreter_sigint_handler);\
        libnormaliz::nmz_interrupted = false; \
        ErrorQuit( "computation interrupted", 0, 0 ); \
        return 0; \
    } catch (...) { \
        signal(SIGINT,current_interpreter_sigint_handler);\
        throw;\
    } \
    signal(SIGINT,current_interpreter_sigint_handler);

extern Obj TheTypeNormalizCone;

#define IS_CONE(o) (TNUM_OBJ(o) == T_NORMALIZ)


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

void signal_handler(int signal)
{
    libnormaliz::nmz_interrupted = true;
}


Obj TheTypeNormalizCone;

UInt T_NORMALIZ = 0;

template<typename Integer>
inline void SET_CONE(Obj o, libnormaliz::Cone<Integer>* p) {
    ADDR_OBJ(o)[0] = reinterpret_cast<Obj>(p);
}

template<typename Integer>
inline libnormaliz::Cone<Integer>* GET_CONE(Obj o) {
    return reinterpret_cast<libnormaliz::Cone<Integer>*>(ADDR_OBJ(o)[0]);
}

Obj NewCone(Cone<mpz_class>* C)
{
    Obj o;
    o = NewBag(T_NORMALIZ, 1 * sizeof(Obj));
    SET_CONE<mpz_class>(o, C);
    return o;
}

Obj NewProxyCone(Cone<mpz_class>* C, Obj parentCone)
{
    Obj o;
    o = NewBag(T_NORMALIZ, 2 * sizeof(Obj) );
    SET_CONE<mpz_class>(o, C);
    ADDR_OBJ(o)[1] = parentCone;
    return o;
}

#define IS_PROXY_CONE(o)  (SIZE_OBJ(o) == 2)

/* Free function */
void NormalizFreeFunc(Obj o)
{
    if (!IS_PROXY_CONE(o)) {
        delete GET_CONE<mpz_class>(o);
    }
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

template<typename Number>
Obj NmzNumberToGAP(Number x)
{
    return Number::unimplemented_function;
}

template<>
Obj NmzNumberToGAP(libnormaliz::key_t x)   // key_t = unsigned int
{
    return ObjInt_UInt(x);
}

#ifdef SYS_IS_64_BIT
template<>
Obj NmzNumberToGAP(size_t x)               // size_t = unsigned long
{
    return ObjInt_UInt(x);
}
#endif

template<>
Obj NmzNumberToGAP(long x)
{
    return ObjInt_Int(x);
}

template<>
Obj NmzNumberToGAP(mpz_class x)
{
    return MpzClassToGAP(x);
}

template<>
Obj NmzNumberToGAP(double x)
{
    return NEW_MACFLOAT(x);
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

template<typename Number>
static Obj NmzVectorToGAP(const vector<Number>& in)
{
    Obj M;
    const size_t n = in.size();
    M = NEW_PLIST((n > 0) ? T_PLIST_CYC : T_PLIST, n);
    SET_LEN_PLIST(M, n);
    for (size_t i = 0; i < n; ++i) {
        SET_ELM_PLIST(M, i+1, NmzNumberToGAP(in[i]));
        CHANGED_BAG( M );
    }
    return M;
}

template<typename Number>
static Obj NmzMatrixToGAP(const vector< vector<Number> >& in)
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

static Obj NmzBoolMatrixToGAP(const vector< vector<bool> >& in)
{
    Obj M;
    Obj N;
    const size_t m = in.size();
    size_t n;
    // TODO: Use BLIST instead
    M = NEW_PLIST(T_PLIST, m);
    SET_LEN_PLIST(M, m);
    for (size_t i = 0; i < m; ++i) {
        n = in[i].size();
        N = NEW_PLIST( T_PLIST, n );
        SET_LEN_PLIST( N, n );
        for( size_t j = 0; j < n; ++j ){
            SET_ELM_PLIST(N, j+1, in[i][j] ? True : False );
        }
        SET_ELM_PLIST( M, i+1, N );
        CHANGED_BAG( M );
    }
    CHANGED_BAG( M );
    return M;
}

/* TODO: HSOP
 *       There are two representations for Hilbert series in Normaliz, standard and HSOP. 
 *       Currently, only the standard representation is returned.
 */
static Obj NmzHilbertSeriesToGAP(const libnormaliz::HilbertSeries& HS)
{
    Obj ret;
    ret = NEW_PLIST(T_PLIST, 3);
    SET_LEN_PLIST(ret, 3);
    AssPlist(ret, 1, NmzVectorToGAP(HS.getNum()));
    AssPlist(ret, 2, NmzVectorToGAP(libnormaliz::to_vector(HS.getDenom())));
    AssPlist(ret, 3, NmzNumberToGAP(HS.getShift()));
    return ret;
}

template<typename Integer>
static Obj NmzWeightedEhrhartSeriesToGAP(const std::pair<libnormaliz::HilbertSeries,Integer>& HS)
{   
    Obj ret;
    ret = NEW_PLIST(T_PLIST, 4);
    SET_LEN_PLIST(ret, 4);
    AssPlist(ret, 1, NmzVectorToGAP(HS.first.getNum()));
    AssPlist(ret, 2, NmzVectorToGAP(libnormaliz::to_vector(HS.first.getDenom())));
    AssPlist(ret, 3, NmzNumberToGAP(HS.first.getShift()));
    AssPlist(ret, 4, NmzNumberToGAP(HS.second));
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
    AssPlist(ret, n+1, NmzNumberToGAP(HS.getHilbertQuasiPolynomialDenom()));
    return ret;
}

static Obj NmzWeightedEhrhartQuasiPolynomialToGAP(const libnormaliz::IntegrationData& int_data)
{
    Obj ret;
    vector< vector<mpz_class> > ehrhart_qp = int_data.getWeightedEhrhartQuasiPolynomial();
    const size_t n = ehrhart_qp.size();
    ret = NEW_PLIST(T_PLIST, n+1);
    for (size_t i = 0; i < n; ++i) {
        SET_ELM_PLIST(ret, i+1 , NmzVectorToGAP(ehrhart_qp[i]));
        CHANGED_BAG( ret );
    }
    AssPlist(ret, n+1, NmzNumberToGAP(int_data.getWeightedEhrhartQuasiPolynomialDenom()));
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
        SET_ELM_PLIST(pair, 2, NmzNumberToGAP(in[i].second));
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
    bool has_polynomial_input = false;
    string polynomial;
    map <InputType, vector< vector<Integer> > > input;
    const int n = LEN_PLIST(input_list);
    if (n&1) {
        throw std::runtime_error("Input list must have even number of elements");
    }
    for (int i = 0; i < n; i += 2) {
        Obj type = ELM_PLIST(input_list, i+1);
        if (!IS_STRING_REP(type)) {
            throw std::runtime_error("Element " + std::to_string(i+1) + " of the input list must be a type string");
        }
        string type_str(CSTR_STRING(type));
        Obj M = ELM_PLIST(input_list, i+2);
        if (type_str.compare("polynomial") == 0) {
            if (!IS_STRING_REP(M)) {
                throw std::runtime_error("Element " + std::to_string(i+2) + " of the input list must be a string");
            }
            polynomial = string(CSTR_STRING(M));
            has_polynomial_input = true;
            continue;
        }
        vector<vector<Integer> > Mat;
        bool okay = GAPIntMatrixToNmz(Mat, M);
        if (!okay) {
            throw std::runtime_error("Element " + std::to_string(i+2) + " of the input list must integer matrix");
        }

        input[libnormaliz::to_type(type_str)] = Mat;
    }

    Cone<Integer>* C = new Cone<Integer>(input);
    if (has_polynomial_input) {
        C->setPolynomial(polynomial);
    }
    Obj Cone = NewCone(C);
    return Cone;

}

Obj _NmzCone(Obj self, Obj input_list)
{
    if (!IS_PLIST(input_list) || !IS_DENSE_LIST(input_list))
        ErrorQuit("Input argument must be a list", 0, 0);

    FUNC_BEGIN
    return _NmzConeIntern<mpz_class>(input_list);
    FUNC_END
}

Obj _NmzCompute(Obj self, Obj cone, Obj to_compute)
{
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (!IS_PLIST(to_compute) || !IS_DENSE_LIST(to_compute))
        ErrorQuit("<props> must be a list of strings", 0, 0);

    FUNC_BEGIN
    ConeProperties propsToCompute;
    // we have a list
    const int n = LEN_PLIST(to_compute);

    for (int i = 0; i < n; ++i) {
        Obj prop = ELM_PLIST(to_compute, i+1);
        if (!IS_STRING_REP(prop)) {
            throw std::runtime_error("Element " + std::to_string(i+1) + " of the input list must be a type string");
        }
        string prop_str(CSTR_STRING(prop));
        propsToCompute.set( libnormaliz::toConeProperty(prop_str) );
    }

    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    
    ConeProperties notComputed;
    SIGNAL_HANDLER_BEGIN
    notComputed = C->compute(propsToCompute);
    SIGNAL_HANDLER_END

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
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (!IS_STRING_REP(prop))
        ErrorQuit("<prop> must be a string", 0, 0);

    FUNC_BEGIN

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
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);

    FUNC_BEGIN

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

    libnormaliz::ConeProperty::Enum p = libnormaliz::toConeProperty(CSTR_STRING(prop));
    ConeProperties notComputed;
    SIGNAL_HANDLER_BEGIN
    notComputed = C->compute(ConeProperties(p));
    SIGNAL_HANDLER_END
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
        return NmzNumberToGAP(C->getTriangulationDetSum());

    case libnormaliz::ConeProperty::Triangulation:
        return NmzTriangleListToGAP<Integer>(C->getTriangulation());

    case libnormaliz::ConeProperty::Multiplicity:
        {
        mpq_class mult = C->getMultiplicity();
        return MpqClassToGAP(mult);
        }

    case libnormaliz::ConeProperty::Integral:
        return MpqClassToGAP(C->getIntegral());

    case libnormaliz::ConeProperty::VirtualMultiplicity:
        return MpqClassToGAP(C->getVirtualMultiplicity());

    case libnormaliz::ConeProperty::RecessionRank:
        return NmzNumberToGAP(C->getRecessionRank());

    case libnormaliz::ConeProperty::AffineDim:
        return NmzNumberToGAP(C->getAffineDim());

    case libnormaliz::ConeProperty::ModuleRank:
        return NmzNumberToGAP(C->getModuleRank());

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

    case libnormaliz::ConeProperty::GradingDenom:
        return NmzNumberToGAP( C->getGradingDenom() );

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
        return NmzNumberToGAP(C->getReesPrimaryMultiplicity());

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

    case libnormaliz::ConeProperty::IsInhomogeneous:
        return C->isInhomogeneous() ? True : False;

    case libnormaliz::ConeProperty::Equations:
        return NmzMatrixToGAP(C->getSublattice().getEquations());
    
    case libnormaliz::ConeProperty::Congruences:
        return NmzMatrixToGAP(C->getSublattice().getCongruences());
    
    case libnormaliz::ConeProperty::EmbeddingDim:
        return NmzNumberToGAP(C->getEmbeddingDim());
    
    case libnormaliz::ConeProperty::Rank:
        return NmzNumberToGAP(C->getRank());
    
    case libnormaliz::ConeProperty::Sublattice:
        return _NmzBasisChangeIntern(C);
    
    case libnormaliz::ConeProperty::IntegerHull:
    {
        Cone<Integer>* int_hull = &(C->getIntegerHullCone());
        return NewProxyCone( int_hull, cone );
    }
    
    case libnormaliz::ConeProperty::HilbertQuasiPolynomial:
        return NmzHilbertQuasiPolynomialToGAP(C->getHilbertSeries());
    
    case libnormaliz::ConeProperty::WeightedEhrhartQuasiPolynomial:
        return NmzWeightedEhrhartQuasiPolynomialToGAP(C->getIntData());
    
    case libnormaliz::ConeProperty::IsTriangulationNested:
        return C->isTriangulationNested() ? True : False;
        
    case libnormaliz::ConeProperty::IsTriangulationPartial:
        return C->isTriangulationPartial() ? True : False;
    
    case libnormaliz::ConeProperty::ConeDecomposition:
        return NmzBoolMatrixToGAP(C->getOpenFacets());
    
    case libnormaliz::ConeProperty::ExternalIndex:
        return NmzNumberToGAP(C->getSublattice().getExternalIndex());
    
    case libnormaliz::ConeProperty::InternalIndex:
        return NmzNumberToGAP(C->getIndex());
    
    case libnormaliz::ConeProperty::WitnessNotIntegrallyClosed:
        return NmzVectorToGAP(C->getWitnessNotIntegrallyClosed());
    
    case libnormaliz::ConeProperty::UnitGroupIndex:
        return NmzNumberToGAP(C->getUnitGroupIndex());
    
    case libnormaliz::ConeProperty::WeightedEhrhartSeries:
        return NmzWeightedEhrhartSeriesToGAP(C->getWeightedEhrhartSeries());
    
    case libnormaliz::ConeProperty::IsGorenstein:
        return C->isGorenstein() ? True : False;
    
    case libnormaliz::ConeProperty::GeneratorOfInterior:
        return NmzVectorToGAP( C->getGeneratorOfInterior() );
    
    case libnormaliz::ConeProperty::VerticesFloat:
        return NmzMatrixToGAP( C->getVerticesFloat() );

//  the following properties are compute options and do not return anything
    case libnormaliz::ConeProperty::DefaultMode:
    case libnormaliz::ConeProperty::Approximate:
    case libnormaliz::ConeProperty::BottomDecomposition:
    case libnormaliz::ConeProperty::KeepOrder:
    case libnormaliz::ConeProperty::NoBottomDec:
    case libnormaliz::ConeProperty::PrimalMode:
    case libnormaliz::ConeProperty::Symmetrize:
    case libnormaliz::ConeProperty::NoSymmetrization:
    case libnormaliz::ConeProperty::BigInt:
    case libnormaliz::ConeProperty::NoNestedTri:
    case libnormaliz::ConeProperty::HSOP:
    case libnormaliz::ConeProperty::Projection:
    case libnormaliz::ConeProperty::NoProjection:
    case libnormaliz::ConeProperty::ProjectionFloat:
    case libnormaliz::ConeProperty::SCIP:
    case libnormaliz::ConeProperty::NoPeriodBound:
        throw "cone property is input-only";

    default:
        throw "unknown cone property";
    }

    return Fail;
}

Obj _NmzConeProperty(Obj self, Obj cone, Obj prop)
{
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (!IS_STRING_REP(prop))
        ErrorQuit("<prop> must be a string", 0, 0);

    FUNC_BEGIN
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
    if (value != True && value != False)
        ErrorQuit("<value> must be a boolean value", 0, 0);
    FUNC_BEGIN
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
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (value != True && value != False)
        ErrorQuit("<value> must be a boolean value", 0, 0);
    bool old_value;

    FUNC_BEGIN
    Cone<mpz_class>* C = GET_CONE<mpz_class>(cone);
    old_value = C->setVerbose(value == True);
    return old_value ? True : False;
    FUNC_END
}

/*
#! @Section Cone properties
*/


template<typename Integer>
static Obj _NmzBasisChangeIntern(Cone<Integer>* C)
{
    Sublattice_Representation<Integer> bc;
    SIGNAL_HANDLER_BEGIN
    bc = C->getSublattice();
    SIGNAL_HANDLER_END

    Obj res = NEW_PLIST(T_PLIST, 3);
    SET_LEN_PLIST(res, 3);
    AssPlist(res, 1, NmzMatrixToGAP(bc.getEmbedding()));
    AssPlist(res, 2, NmzMatrixToGAP(bc.getProjection()));
    AssPlist(res, 3, NmzNumberToGAP(bc.getAnnihilator()));
    // Dim, Rank, Equations and Congruences are already covered by special functions
    // The index is not always computed and not so relevant
    return res;
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

    T_NORMALIZ = RegisterPackageTNUM("NormalizCone", NormalizTypeFunc);

    InitMarkFuncBags(T_NORMALIZ, &MarkAllSubBags);
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
