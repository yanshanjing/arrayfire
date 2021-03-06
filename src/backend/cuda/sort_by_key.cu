/*******************************************************
 * Copyright (c) 2014, ArrayFire
 * All rights reserved.
 *
 * This file is distributed under 3-clause BSD license.
 * The complete license agreement can be obtained at:
 * http://arrayfire.com/licenses/BSD-3-Clause
 ********************************************************/

#include <Array.hpp>
#include <copy.hpp>
#include <sort_by_key.hpp>
#include <kernel/sort_by_key.hpp>
#include <math.hpp>
#include <stdexcept>
#include <err_cuda.hpp>

namespace cuda
{
    template<typename Tk, typename Tv, bool DIR>
    void sort_by_key(Array<Tk> &okey, Array<Tv> &oval,
               const Array<Tk> &ikey, const Array<Tv> &ival, const uint dim)
    {
        okey = *copyArray<Tk>(ikey);
        oval = *copyArray<Tv>(ival);
        switch(dim) {
        case 0: kernel::sort0_by_key<Tk, Tv, DIR>(okey, oval);
            break;
        default: AF_ERROR("Not Supported", AF_ERR_NOT_SUPPORTED);
        }
    }

#define INSTANTIATE(Tk, Tv)                                             \
    template void                                                       \
    sort_by_key<Tk, Tv, true>(Array<Tk> &okey, Array<Tv> &oval,         \
                              const Array<Tk> &ikey, const Array<Tv> &ival, const uint dim); \
    template void                                                       \
    sort_by_key<Tk, Tv,false>(Array<Tk> &okey, Array<Tv> &oval,         \
                              const Array<Tk> &ikey, const Array<Tv> &ival, const uint dim); \

#define INSTANTIATE1(Tk)       \
    INSTANTIATE(Tk, float)     \
    INSTANTIATE(Tk, double)    \
    INSTANTIATE(Tk, int)       \
    INSTANTIATE(Tk, uint)      \
    INSTANTIATE(Tk, char)      \
    INSTANTIATE(Tk, uchar)     \

    INSTANTIATE1(float)
    INSTANTIATE1(double)
    INSTANTIATE1(int)
    INSTANTIATE1(uint)
    INSTANTIATE1(char)
    INSTANTIATE1(uchar)
}
