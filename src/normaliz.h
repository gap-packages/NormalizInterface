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

#ifndef GAP_NORMALIZ_H
#define GAP_NORMALIZ_H

// Include gmp.h *before* switching to C mode, because GMP detects when compiled from C++
// and then does some things differently, which would cause an error if
// called from within extern "C". But libsing.h (indirectly) includes gmp.h ...
#include <gmp.h>

extern "C" {
#include "src/compiled.h"          /* GAP headers                */
}
#include "libnormaliz/cone.h"
#include <assert.h>

// the TNUM used for NormalizInterface objects,
extern UInt T_NORMALIZ;

// old versions of libnormaliz (before 2.99.1) did not include such a define
#ifndef NMZ_RELEASE
    static_assert(false,
       "Your Normaliz version (unknown) is to old! Update to 3.0.0 or newer.");
#endif
#if NMZ_RELEASE < 30000
    static_assert(false, "Your Normaliz version is to old! Update to 3.0.0 or newer.");
#endif

#define FUNC_BEGIN try {

#define FUNC_END \
    } catch (libnormaliz::NormalizException& e) { \
        ErrorQuit("Normaliz exeption thrown",0,0); \
        return Fail; \
    } catch (...) { \
        ErrorQuit("unknown exeption thrown",0,0); \
        return Fail; \
    }

extern Obj TheTypeNormalizCone;

template<typename Integer>
inline void SET_CONE(Obj o, libnormaliz::Cone<Integer>* p) {
    ADDR_OBJ(o)[0] = reinterpret_cast<Obj>(p);
}

template<typename Integer>
inline libnormaliz::Cone<Integer>* GET_CONE(Obj o) {
    return reinterpret_cast<libnormaliz::Cone<Integer>*>(ADDR_OBJ(o)[0]);
}

#define IS_CONE(o) (TNUM_OBJ(o) == T_NORMALIZ)


void NormalizFreeFunc(Obj o);
Obj NormalizTypeFunc(Obj o);

#endif
