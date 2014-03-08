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

#ifndef T_NORMALIZ
#define T_NORMALIZ T_SPARE1
#endif

#define FUNC_BEGIN try\
                    {

#define FUNC_END   } catch (libnormaliz::NormalizException& e) { \
                   ErrorQuit("Normaliz exeption thrown",0,0); \
                   return Fail; \
                   }


extern Obj TheTypeNormalizCone;

#define SET_CONE(o, p) (ADDR_OBJ(o)[1] = reinterpret_cast<Obj>(p))
#define GET_CONE(o) (reinterpret_cast<Cone<long>*>(ADDR_OBJ(o)[1]))

#define IS_CONE(o) (TNUM_OBJ(o)==T_NORMALIZ && \
                    (UInt)(ADDR_OBJ(o)[0])==(UInt)TheTypeNormalizCone)

Obj NewCone(libnormaliz::Cone<long>*);
void NormalizFreeFunc(Obj o);
Obj NormalizTypeFunc(Obj o);

#endif
