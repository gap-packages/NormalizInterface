/*
 * NormalizInterface: GAP wrapper for Normaliz
 * Copyright (C) 2014  Sebastian Gutsche, Max Horn, Christof Söger
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the Free
 * Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

/*
#! @Chapter Functions
#! @Section YOU FORGOT TO SET A SECTION
*/

#include "src/compiled.h" /* GAP headers                */

#include "libnormaliz/cone.h"
#include "libnormaliz/map_operations.h"

#include <vector>

#include <csignal>
using std::signal;

typedef void (*sighandler_t)(int);

// old versions of libnormaliz (before 2.99.1) did not include such a define
#if !defined(NMZ_RELEASE) || NMZ_RELEASE < 30504
#error Your Normaliz version is to old! Update to 3.5.4 or newer.
#endif

#define FUNC_BEGIN try {

#define FUNC_END                                                             \
    }                                                                        \
    catch (std::exception & e)                                               \
    {                                                                        \
        ErrorQuit(e.what(), 0, 0);                                           \
        return Fail;                                                         \
    }                                                                        \
    catch (const char * a)                                                   \
    {                                                                        \
        ErrorQuit(a, 0, 0);                                                  \
        return Fail;                                                         \
    }                                                                        \
    catch (const std::string & a)                                            \
    {                                                                        \
        ErrorQuit(a.c_str(), 0, 0);                                          \
        return Fail;                                                         \
    }                                                                        \
    catch (...)                                                              \
    {                                                                        \
        ErrorQuit("PANIC: caught general exception", 0, 0);                  \
        return Fail;                                                         \
    }

#define SIGNAL_HANDLER_BEGIN                                                 \
    sighandler_t current_interpreter_sigint_handler =                        \
        signal(SIGINT, signal_handler);                                      \
    try {

#define SIGNAL_HANDLER_END                                                   \
    }                                                                        \
    catch (libnormaliz::InterruptException & e)                              \
    {                                                                        \
        signal(SIGINT, current_interpreter_sigint_handler);                  \
        libnormaliz::nmz_interrupted = false;                                \
        ErrorQuit("computation interrupted", 0, 0);                          \
        return 0;                                                            \
    }                                                                        \
    catch (...)                                                              \
    {                                                                        \
        signal(SIGINT, current_interpreter_sigint_handler);                  \
        throw;                                                               \
    }                                                                        \
    signal(SIGINT, current_interpreter_sigint_handler);


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
// using libnormaliz::ConeProperty;
using libnormaliz::ConeProperties;
using libnormaliz::Sublattice_Representation;
using libnormaliz::Type::InputType;

using std::map;
using std::string;
using std::vector;

static void signal_handler(int signal)
{
    libnormaliz::nmz_interrupted = true;
}

static Obj TheTypeNormalizCone;

static UInt T_NORMALIZ = 0;

static inline bool IS_CONE(Obj o)
{
    return TNUM_OBJ(o) == T_NORMALIZ;
}

template <typename Integer>
static inline void SET_CONE(Obj o, libnormaliz::Cone<Integer> * p)
{
    ADDR_OBJ(o)[0] = reinterpret_cast<Obj>(p);
}

template <typename Integer>
static inline libnormaliz::Cone<Integer> * GET_CONE(Obj o)
{
    return reinterpret_cast<libnormaliz::Cone<Integer> *>(ADDR_OBJ(o)[0]);
}

static Obj NewCone(Cone<mpz_class> * C)
{
    Obj o;
    o = NewBag(T_NORMALIZ, 1 * sizeof(Obj));
    SET_CONE<mpz_class>(o, C);
    return o;
}

static Obj NewProxyCone(Cone<mpz_class> * C, Obj parentCone)
{
    Obj o;
    o = NewBag(T_NORMALIZ, 2 * sizeof(Obj));
    SET_CONE<mpz_class>(o, C);
    ADDR_OBJ(o)[1] = parentCone;
    return o;
}

/* Free function */
static void NormalizFreeFunc(Obj o)
{
    if (SIZE_OBJ(o) != 2 * sizeof(Obj)) {
        delete GET_CONE<mpz_class>(o);
    }
}

/* Type object function for the object */
static Obj NormalizTypeFunc(Obj o)
{
    return TheTypeNormalizCone;
}

static Obj NormalizCopyFunc(Obj o, Int mut)
{
    // Cone objects are mathematically immutable, so
    // we don't need to do anything,
    return o;
}

static void NormalizCleanFunc(Obj o)
{
}

static Int NormalizIsMutableObjFuncs(Obj o)
{
    // Cone objects are mathematically immutable.
    return 0L;
}

//
// conversion of various C++ types to GAP objects
//

template <typename T, typename U>
static Obj NmzToGAP(const std::pair<T, U> & in);

template <typename T>
static Obj NmzToGAP(const vector<T> & in);

static Obj NmzToGAP(const mpz_t x)
{
#if GAP_KERNEL_MAJOR_VERSION >= 7
    return MakeObjInt((const UInt *)x->_mp_d,
                      x->_mp_size);    // added in GAP 4.11
#else
    Obj res;
    Int size = x->_mp_size;
    int sign;
    if (size == 0) {
        return INTOBJ_INT(0);
    }
    else if (size < 0) {
        size = -size;
        sign = -1;
    }
    else {
        sign = +1;
    }
    if (size == 1) {
        res = ObjInt_UInt(x->_mp_d[0]);
        if (sign < 0)
            res = AInvInt(res);
    }
    else {
        size = sizeof(mp_limb_t) * size;
        if (sign > 0)
            res = NewBag(T_INTPOS, size);
        else
            res = NewBag(T_INTNEG, size);
        memcpy(ADDR_INT(res), x->_mp_d, size);
    }
    return res;
#endif
}

static Obj NmzToGAP(unsigned int x)    // key_t = unsigned int
{
    return ObjInt_UInt(x);
}

static Obj NmzToGAP(unsigned long x)    // size_t = unsigned long
{
    return ObjInt_UInt(x);
}

static Obj NmzToGAP(int x)
{
    return ObjInt_Int(x);
}

static Obj NmzToGAP(long x)
{
    return ObjInt_Int(x);
}

static Obj NmzToGAP(mpz_class x)
{
    return NmzToGAP(x.get_mpz_t());
}

static Obj NmzToGAP(mpq_class x)
{
    Obj num = NmzToGAP(x.get_num());
    Obj den = NmzToGAP(x.get_den());
    return QUO(num, den);
}

static Obj NmzToGAP(double x)
{
    return NEW_MACFLOAT(x);
}

template <typename T>
static Obj NmzToGAP(const libnormaliz::STANLEYDATA<T> & sd)
{
    Obj ret = NEW_PLIST(T_PLIST, 2);
    ASS_LIST(ret, 1, NmzToGAP(sd.key));
    ASS_LIST(ret, 2, NmzToGAP(sd.offsets));
    return ret;
}

/* TODO: HSOP
 *       There are two representations for Hilbert series in Normaliz,
 * standard and HSOP. Currently, only the standard representation is returned.
 */
static Obj NmzToGAP(const libnormaliz::HilbertSeries & HS)
{
    Obj ret;
    ret = NEW_PLIST(T_PLIST, 3);
    ASS_LIST(ret, 1, NmzToGAP(HS.getNum()));
    ASS_LIST(ret, 2, NmzToGAP(libnormaliz::to_vector(HS.getDenom())));
    ASS_LIST(ret, 3, NmzToGAP(HS.getShift()));
    return ret;
}

static Obj
NmzHilbertQuasiPolynomialToGAP(const libnormaliz::HilbertSeries & HS)
{
    Obj ret = NmzToGAP(HS.getHilbertQuasiPolynomial());
    AddList(ret, NmzToGAP(HS.getHilbertQuasiPolynomialDenom()));
    return ret;
}

//
// generic recursive conversion of C++ containers to GAP objects
//

// convert maps to list of [key,value] pairs
template <typename K, typename V>
static Obj NmzToGAP(const map<K, V> & in)
{
    Obj list = NEW_PLIST(T_PLIST, in.size());
    for (const auto & it : in) {
        AddList(list, NmzToGAP(it));
    }
    return list;
}

template <typename T>
static Obj NmzToGAP(const std::list<T> & in)
{
    Obj list = NEW_PLIST(T_PLIST, in.size());
    for (const auto & it : in) {
        AddList(list, NmzToGAP(it));
    }
    return list;
}

template <typename T>
static Obj NmzToGAP(const vector<T> & in)
{
    const size_t n = in.size();
    Obj          list = NEW_PLIST(T_PLIST, n);
    for (size_t i = 0; i < n; ++i) {
        ASS_LIST(list, i + 1, NmzToGAP(in[i]));
    }
    return list;
}

template <>
Obj NmzToGAP(const vector<bool> & in)
{
    const size_t n = in.size();
    Obj          list = NewBag(T_BLIST, SIZE_PLEN_BLIST(n));
    SET_LEN_BLIST(list, n);
    for (size_t i = 0; i < n; ++i) {
        if (in[i])
            SET_BIT_BLIST(list, i + 1);
    }
    return list;
}

static Obj NmzToGAP(const boost::dynamic_bitset<> & in)
{
    const size_t n = in.size();
    Obj          list = NewBag(T_BLIST, SIZE_PLEN_BLIST(n));
    SET_LEN_BLIST(list, n);
    for (size_t i = 0; i < n; ++i) {
        if (in.test(i))
            SET_BIT_BLIST(list, i + 1);
    }
    return list;
}

template <typename T, typename U>
static Obj NmzToGAP(const std::pair<T, U> & in)
{
    Obj pair = NEW_PLIST(T_PLIST, 2);
    ASS_LIST(pair, 1, NmzToGAP(in.first));
    ASS_LIST(pair, 2, NmzToGAP(in.second));
    return pair;
}

// TODO: generate a "proper" MatrixObj, once available
template <typename T>
static Obj NmzToGAP(const libnormaliz::Matrix<T> & in)
{
    return NmzToGAP(in.get_elements());
}

bool GAPNumberToNmz(long & out, Obj x)
{
    if (IS_INTOBJ(x)) {
        out = INT_INTOBJ(x);
        return true;
    }
    else if (TNUM_OBJ(x) == T_INTPOS || TNUM_OBJ(x) == T_INTNEG) {
        UInt size = SIZE_INT(x);
        if (size == 1) {
            out = *ADDR_INT(x);
            if (out < 0)
                return false;    // overflow
            if (TNUM_OBJ(x) == T_INTNEG)
                out = -out;
            return true;
        }
    }
    return false;
}

bool GAPNumberToNmz(mpz_class & out, Obj x)
{
    if (IS_INTOBJ(x)) {
        out = INT_INTOBJ(x);
        return true;
    }
    else if (TNUM_OBJ(x) == T_INTPOS || TNUM_OBJ(x) == T_INTNEG) {
        UInt    size = SIZE_INT(x);
        mpz_ptr m = out.get_mpz_t();
        mpz_realloc2(m, size * GMP_NUMB_BITS);
        memcpy(m->_mp_d, ADDR_INT(x), sizeof(mp_limb_t) * size);
        m->_mp_size = (TNUM_OBJ(x) == T_INTPOS) ? (Int)size : -(Int)size;
        return true;
    }
    return false;
}

bool GAPNumberToNmz(mpq_class & out, Obj x)
{
    if (IS_INTOBJ(x)) {
        out = INT_INTOBJ(x);
        return true;
    }
    else if (TNUM_OBJ(x) == T_INTPOS || TNUM_OBJ(x) == T_INTNEG) {
        out.get_den() = 1;
        return GAPNumberToNmz(out.get_num(), x);
    }
    else if (TNUM_OBJ(x) == T_RAT) {
        return GAPNumberToNmz(out.get_num(), NUM_RAT(x)) &&
               GAPNumberToNmz(out.get_den(), DEN_RAT(x));
    }
    return false;
}

template <typename Number>
static bool GAPVectorToNmz(vector<Number> & out, Obj V)
{
    if (!IS_PLIST(V) || !IS_DENSE_LIST(V))
        return false;
    const int n = LEN_PLIST(V);
    out.resize(n);
    for (int i = 0; i < n; ++i) {
        Obj tmp = ELM_PLIST(V, i + 1);
        if (!GAPNumberToNmz(out[i], tmp))
            return false;
    }
    return true;
}

template <typename Number>
static bool GAPMatrixToNmz(vector<vector<Number>> & out, Obj M)
{
    if (!IS_PLIST(M) || !IS_DENSE_LIST(M))
        return false;
    const int nr = LEN_PLIST(M);
    out.resize(nr);
    for (int i = 0; i < nr; ++i) {
        bool okay = GAPVectorToNmz(out[i], ELM_PLIST(M, i + 1));
        if (!okay)
            return false;
    }
    return true;
}

template <typename Integer>
static Obj _NmzConeIntern(Obj input_list)
{
    bool                                      has_polynomial_input = false;
    string                                    polynomial;
    map<InputType, vector<vector<mpq_class>>> input;
    const int                                 n = LEN_PLIST(input_list);
    if (n & 1) {
        throw std::runtime_error(
            "Input list must have even number of elements");
    }
    for (int i = 0; i < n; i += 2) {
        Obj type = ELM_PLIST(input_list, i + 1);
        if (!IS_STRING_REP(type)) {
            throw std::runtime_error(
                "Element " + std::to_string(i + 1) +
                " of the input list must be a type string");
        }
        string type_str(CSTR_STRING(type));
        Obj    M = ELM_PLIST(input_list, i + 2);
        if (type_str.compare("polynomial") == 0) {
            if (!IS_STRING_REP(M)) {
                throw std::runtime_error(
                    "Element " + std::to_string(i + 2) +
                    " of the input list must be a string");
            }
            polynomial = string(CSTR_STRING(M));
            has_polynomial_input = true;
            continue;
        }
        vector<vector<mpq_class>> Mat;
        bool                      okay = GAPMatrixToNmz(Mat, M);
        if (!okay) {
            throw std::runtime_error(
                "Element " + std::to_string(i + 2) +
                " of the input list must be an integer matrix");
        }

        input[libnormaliz::to_type(type_str)] = Mat;
    }

    Cone<Integer> * C = new Cone<Integer>(input);
    if (has_polynomial_input) {
        C->setPolynomial(polynomial);
    }
    Obj Cone = NewCone(C);
    return Cone;
}

static Obj Func_NmzCone(Obj self, Obj input_list)
{
    if (!IS_PLIST(input_list) || !IS_DENSE_LIST(input_list))
        ErrorQuit("Input argument must be a list", 0, 0);

    FUNC_BEGIN
    return _NmzConeIntern<mpz_class>(input_list);
    FUNC_END
}

static Obj Func_NmzCompute(Obj self, Obj cone, Obj to_compute)
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
        Obj prop = ELM_PLIST(to_compute, i + 1);
        if (!IS_STRING_REP(prop)) {
            throw std::runtime_error(
                "Element " + std::to_string(i + 1) +
                " of the input list must be a type string");
        }
        string prop_str(CSTR_STRING(prop));
        propsToCompute.set(libnormaliz::toConeProperty(prop_str));
    }

    Cone<mpz_class> * C = GET_CONE<mpz_class>(cone);

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
#! @InsertChunk NmzHasConeProperty_example
DeclareGlobalFunction("NmzHasConeProperty");
*/
static Obj FuncNmzHasConeProperty(Obj self, Obj cone, Obj prop)
{
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (!IS_STRING_REP(prop))
        ErrorQuit("<prop> must be a string", 0, 0);

    FUNC_BEGIN

    libnormaliz::ConeProperty::Enum p =
        libnormaliz::toConeProperty(CSTR_STRING(prop));

    Cone<mpz_class> * C = GET_CONE<mpz_class>(cone);
    return C->isComputed(p) ? True : False;

    FUNC_END
}

/*
#! @Section Use a NmzCone
#! @Arguments cone
#! @Returns a list of strings representing the known (computed) cone
#!   properties
#! @Description
#! Given a Normaliz cone object, return a list of all properties already
#! computed for the cone.
#!
#! @InsertChunk NmzKnownConeProperties_example
DeclareGlobalFunction("NmzKnownConeProperties");
*/
static Obj FuncNmzKnownConeProperties(Obj self, Obj cone)
{
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);

    FUNC_BEGIN

    size_t n = 0;
    Obj    M = NEW_PLIST(T_PLIST, libnormaliz::ConeProperty::EnumSize);
    Cone<mpz_class> * C = GET_CONE<mpz_class>(cone);

    // FIXME: This code could be a lot simpler if there was
    // a Cone method for reading the value of is_Computed.
    for (int i = 0; i < libnormaliz::ConeProperty::EnumSize; ++i) {
        libnormaliz::ConeProperty::Enum p =
            (libnormaliz::ConeProperty::Enum)i;

        // skip internal control properties
        if (p == libnormaliz::ConeProperty::ExplicitHilbertSeries ||
            p == libnormaliz::ConeProperty::NakedDual)
            continue;

        if (C->isComputed(p)) {
            string prop_name(libnormaliz::toString(p));

            ASS_LIST(M, ++n, MakeImmString(prop_name.c_str()));
            if (p == libnormaliz::ConeProperty::HilbertSeries) {
                const libnormaliz::HilbertSeries & HS = C->getHilbertSeries();
                HS.computeHilbertQuasiPolynomial();
                if (HS.isHilbertQuasiPolynomialComputed()) {
                    ASS_LIST(M, ++n, MakeImmString("HilbertQuasiPolynomial"));
                }
            }
        }
    }
    return M;

    FUNC_END
}

template <typename Integer>
static Obj _NmzConePropertyImpl(Obj cone, Obj prop)
{
    Cone<Integer> * C = GET_CONE<Integer>(cone);

    libnormaliz::ConeProperty::Enum p =
        libnormaliz::toConeProperty(CSTR_STRING(prop));
    ConeProperties notComputed;
    SIGNAL_HANDLER_BEGIN
    notComputed = C->compute(ConeProperties(p));
    SIGNAL_HANDLER_END
#if NMZ_RELEASE >= 30700
    // workaround a bug where computing HilbertQuasiPolynomial after
    // HilbertSeries was already computed returned notComputed equal to
    // NoGradingDenom, even though of course the quasi polynomial was
    // available.
    notComputed.reset(libnormaliz::ConeProperty::NoGradingDenom);
#endif
    if (notComputed.any()) {
        ErrorQuit("Failed to compute %s, missing properties: %s",
                  (Int)(libnormaliz::toString(p).c_str()),
                  (Int)(libnormaliz::toString(notComputed).c_str()));
        return Fail;
    }

    // workaround bug in certain Normaliz versions, where the output type for
    // ClassGroups is reported as libnormaliz::OutputType::Vector, but calling
    // getVectorConeProperty on it produces an error
    if (p == libnormaliz::ConeProperty::ClassGroup)
        return NmzToGAP(C->getClassGroup());

#if NMZ_RELEASE >= 30700 && NMZ_RELEASE < 30703
    // workaround bug where getMachineIntegerConeProperty does not support
    // NumberLatticePoints
    if (p == libnormaliz::ConeProperty::NumberLatticePoints)
        return NmzToGAP(C->getNumberLatticePoints());
#endif

    // workaround: these two properties are marked as having output type
    // "void"
    if (p == libnormaliz::ConeProperty::IsTriangulationNested)
        return C->isTriangulationNested() ? True : False;
    if (p == libnormaliz::ConeProperty::IsTriangulationPartial)
        return C->isTriangulationPartial() ? True : False;

    switch (libnormaliz::output_type(p)) {
    case libnormaliz::OutputType::Matrix:
        // TODO: switch to getMatrixConePropertyMatrix ?
        return NmzToGAP(C->getMatrixConeProperty(p));

    case libnormaliz::OutputType::MatrixFloat:
        return NmzToGAP(C->getFloatMatrixConeProperty(p));

    case libnormaliz::OutputType::Vector:
        return NmzToGAP(C->getVectorConeProperty(p));

    case libnormaliz::OutputType::Integer:
        return NmzToGAP(C->getIntegerConeProperty(p));

    case libnormaliz::OutputType::GMPInteger:
        return NmzToGAP(C->getGMPIntegerConeProperty(p));

    case libnormaliz::OutputType::Rational:
        return NmzToGAP(C->getRationalConeProperty(p));

#if NMZ_RELEASE >= 30700
    case libnormaliz::OutputType::FieldElem:
        throw "OutputType::FieldElem not yet supported";
#endif

    case libnormaliz::OutputType::Float:
        return NmzToGAP(C->getFloatConeProperty(p));

    case libnormaliz::OutputType::MachineInteger:
        return NmzToGAP(C->getMachineIntegerConeProperty(p));

    case libnormaliz::OutputType::Bool:
        return C->getBooleanConeProperty(p) ? True : False;

    case libnormaliz::OutputType::Complex:
        // more complex data structures are handled below
        break;

    case libnormaliz::OutputType::Void:
        // throw "cone property is input-only";
        return Fail;

    default:
        throw "unsupported output_type";
    }

    switch (p) {
#if NMZ_RELEASE >= 30703
    case libnormaliz::ConeProperty::AmbientAutomorphisms:
    case libnormaliz::ConeProperty::Automorphisms:
    case libnormaliz::ConeProperty::CombinatorialAutomorphisms:
    case libnormaliz::ConeProperty::EuclideanAutomorphisms:
    case libnormaliz::ConeProperty::RationalAutomorphisms:
        throw "querying automorphisms not yet supported";
#endif

    case libnormaliz::ConeProperty::ConeDecomposition:
        return NmzToGAP(C->getOpenFacets());

#if NMZ_RELEASE >= 30600
    case libnormaliz::ConeProperty::EhrhartQuasiPolynomial:
#if NMZ_RELEASE >= 30700
        return NmzHilbertQuasiPolynomialToGAP(C->getEhrhartSeries());
#else
        throw "Extracting EhrhartQuasiPolynomial requires Normaliz >= 3.7.0";
#endif
#endif

    case libnormaliz::ConeProperty::EhrhartSeries:
#if NMZ_RELEASE >= 30700
        return NmzToGAP(C->getEhrhartSeries());
#else
        throw "Extracting EhrhartSeries requires Normaliz >= 3.7.0";
#endif

#if NMZ_RELEASE >= 30700
    case libnormaliz::ConeProperty::FaceLattice:
        return NmzToGAP(C->getFaceLattice());

    case libnormaliz::ConeProperty::FVector:
        return NmzToGAP(C->getFVector());
#endif

    case libnormaliz::ConeProperty::HilbertQuasiPolynomial:
        return NmzHilbertQuasiPolynomialToGAP(C->getHilbertSeries());

    case libnormaliz::ConeProperty::HilbertSeries:
        return NmzToGAP(C->getHilbertSeries());

    case libnormaliz::ConeProperty::InclusionExclusionData:
        return NmzToGAP(C->getInclusionExclusionData());

    case libnormaliz::ConeProperty::IntegerHull:
        return NewProxyCone(&(C->getIntegerHullCone()), cone);

    case libnormaliz::ConeProperty::ProjectCone:
        return NewProxyCone(&(C->getProjectCone()), cone);

    case libnormaliz::ConeProperty::Sublattice:
        return _NmzBasisChangeIntern(C);

    case libnormaliz::ConeProperty::StanleyDec:
        return NmzToGAP(C->getStanleyDec());

    case libnormaliz::ConeProperty::Triangulation:
        return NmzToGAP(C->getTriangulation());

    case libnormaliz::ConeProperty::WeightedEhrhartQuasiPolynomial:
        return NmzHilbertQuasiPolynomialToGAP(
            C->getWeightedEhrhartSeries().first);

    case libnormaliz::ConeProperty::WeightedEhrhartSeries:
        return NmzToGAP(C->getWeightedEhrhartSeries());

    default:
        throw "unsupported cone property " + libnormaliz::toString(p);
    }

    return Fail;
}

static Obj Func_NmzConeProperty(Obj self, Obj cone, Obj prop)
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
#! This will influence all NmzCone created afterwards, but not any existing
#! ones.
#!
#! See also <Ref Func="NmzSetVerbose"/>
DeclareGlobalFunction("NmzSetVerboseDefault");
*/
static Obj FuncNmzSetVerboseDefault(Obj self, Obj value)
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
static Obj FuncNmzSetVerbose(Obj self, Obj cone, Obj value)
{
    if (!IS_CONE(cone))
        ErrorQuit("<cone> must be a Normaliz cone", 0, 0);
    if (value != True && value != False)
        ErrorQuit("<value> must be a boolean value", 0, 0);
    bool old_value;

    FUNC_BEGIN
    Cone<mpz_class> * C = GET_CONE<mpz_class>(cone);
    old_value = C->setVerbose(value == True);
    return old_value ? True : False;
    FUNC_END
}

/*
#! @Section Cone properties
*/


template <typename Integer>
static Obj _NmzBasisChangeIntern(Cone<Integer> * C)
{
    Sublattice_Representation<Integer> bc;
    SIGNAL_HANDLER_BEGIN
    bc = C->getSublattice();
    SIGNAL_HANDLER_END

    Obj res = NEW_PLIST(T_PLIST, 3);
    ASS_LIST(res, 1, NmzToGAP(bc.getEmbedding()));
    ASS_LIST(res, 2, NmzToGAP(bc.getProjection()));
    ASS_LIST(res, 3, NmzToGAP(bc.getAnnihilator()));
    // Dim, Rank, Equations and Congruences are already covered by special
    // functions The index is not always computed and not so relevant
    return res;
}


static Obj Func_NmzVersion(Obj self)
{
    Obj res = NEW_PLIST(T_PLIST, 3);
    ASS_LIST(res, 1, INTOBJ_INT(NMZ_VERSION_MAJOR));
    ASS_LIST(res, 2, INTOBJ_INT(NMZ_VERSION_MINOR));
    ASS_LIST(res, 3, INTOBJ_INT(NMZ_VERSION_PATCH));
    return res;
}

// GVAR_FUNC in GAP 4.9 and 4.10 triggers warnings when used in C++ code; so
// we force it to the definition from GAP 4.11
#undef GVAR_FUNC
#define GVAR_FUNC(name, nargs, args)                                         \
    {                                                                        \
#name, nargs, args, (ObjFunc)Func##name, __FILE__ ":" #name          \
    }

// Table of functions to export
static StructGVarFunc GVarFuncs[] = {
    GVAR_FUNC(_NmzCone, 1, "list"),

    GVAR_FUNC(_NmzCompute, 2, "cone, props"),
    GVAR_FUNC(NmzSetVerboseDefault, 1, "value"),
    GVAR_FUNC(NmzSetVerbose, 2, "cone, value"),

    GVAR_FUNC(NmzHasConeProperty, 2, "cone, prop"),
    GVAR_FUNC(_NmzConeProperty, 2, "cone, prop"),
    GVAR_FUNC(NmzKnownConeProperties, 1, "cone"),

    GVAR_FUNC(_NmzVersion, 0, ""),

    { 0 } /* Finish with an empty entry */

};

// initialise kernel data structures
static Int InitKernel(StructInitInfo * module)
{
    /* init filters and functions                                          */
    InitHdlrFuncsFromTable(GVarFuncs);

    InitCopyGVar("TheTypeNormalizCone", &TheTypeNormalizCone);

    T_NORMALIZ = RegisterPackageTNUM("NormalizCone", NormalizTypeFunc);

    InitMarkFuncBags(T_NORMALIZ, &MarkAllSubBags);
    InitFreeFuncBag(T_NORMALIZ, &NormalizFreeFunc);

    CopyObjFuncs[T_NORMALIZ] = &NormalizCopyFunc;
    CleanObjFuncs[T_NORMALIZ] = &NormalizCleanFunc;
    IsMutableObjFuncs[T_NORMALIZ] = &NormalizIsMutableObjFuncs;

    /* return success                                                      */
    return 0;
}

// initialise library data structures
static Int InitLibrary(StructInitInfo * module)
{
    /* init filters and functions */
    InitGVarFuncsFromTable(GVarFuncs);

    /* return success                                                      */
    return 0;
}

// table of init functions
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
extern "C" StructInitInfo * Init__Dynamic(void)
{
    return &module;
}
#endif

extern "C" StructInitInfo * Init__normaliz(void)
{
    return &module;
}
