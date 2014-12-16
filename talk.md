# Mixed Martial Arts

## Jonas Juselius <jonas.juselius@uit.no>

HPC@UiT

---

layout: false

## Why
* There exists no perfect language for all tasks
* Languages have different stenghts:
    * Python is excellent for driving computations and pre- and
      post-processing results
    * Fortran is suitable for high-performance linear algebra and
      mathematical programming
    * C++ supports advanced data structures, generic programming and more
    * C is the mother tongue of UNIX
    * Haskell is purely functional and lazy
* Coupling functionality from existing programs

---

## How
* C is the common denominator
* Export needed functionality to C
* Often necessary to modularize the host code:
    * init()
    * step()
    * finalize()
    * \+ accessors
* Couple either directly or via Cython
* Use CMake to build and link

---

## Fortran
* Use iso_c_binding
* Calling conventions:
    * Pass by value
    * bind(C)
    * c_ptr, c_loc, c_f_pointer
    * Column vs. row major matrices

---

## Fortran calling C
```{Fortran
module ccall
    use, intrinsic :: iso_c_binding
    implicit none
    interface
        function cwork(n, matrix) result(r) bind(c)
            import
            integer(C_INT), value :: n
            type(C_PTR), value :: matrix
            real(C_DOUBLE) :: r
        end function
    end interface
contains
    function work(n, matrix) result(r)
        integer :: n
        real(8), dimension(n,n), target :: matrix
        real(8) :: r
        r = cwork(n, c_loc(matrix(1,1)))
    end function
end module
```

---

## C calling Fortran
```{Fortran}
module fwork_module
    use, intrinsic :: iso_c_binding
    implicit none
contains
    function fwork(n, vec) result(r) bind(c)
        integer(C_INT), value :: n
        type(C_PTR), value :: vec
        real(C_FLOAT) :: r
        real, dimension(:), pointer :: fvec
        call c_f_pointer(vec, fvec, [n])
        call do_some_work(fvec, r)
    end function
end module
```

```{C}
int fwork(int, float *); // normally defined in header file

int work() {
    int x;
    float y[100];
    x = fwork(100, y);
    return 0;
}
```

---

## C++
C++ cannot be directly linked due to name mangling.

```{C++}
#ifdef __cplusplus
class Workhorse {
public:
    Workhorse() {}
    virtual ~Workhorse() {}
    int work(int n, float *vec) { return n; }
}
#else
typedef struct Workhorse Workhorse;
#endif

#ifdef __cplusplus
extern "C" {
#endif
int workhorse__work(AClass *a, int n, float *vec) {
    return a->work(n, vec);
}
#ifdef __cplusplus
}
#endif
```

---

## Cython
* Compile Python to C!
    * Speedup Pyhton
    * Call external C/C++ functions directly
    * Pass arrays via numpy
    * Use CMake!

* https://github.com/bakerjonas/python-tutorials/tree/master/Cython

---

## Cython for speed
```{cython}
def f(double x):
    return x**2-x

def integrate_f(double a, double b, int N):
    cdef int i
    cdef double s, dx
    s = 0
    dx = (b-a)/N
    for i in range(N):
        s += f(a+i*dx)
    return s * dx

```

---

## Cython calling C
```{cython}
cimport numpy as cnp
import numpy as np

cdef extern from "fwork.h":
    int fwork(int, float *)

def py_fwork(int n):
    cdef cnp.ndarray ax, c
    ax = np.arange(a, b, (b-a)/float(n))
    c = np.ndarray(n), dtype=np.float32, order='F')
    i = fwork(n, <float *> ax.data)
    return (i, c)

```

---

## Calling Cython from Python
```{cython}
import cyspeed
import pywork

print py_fwork(1000)
print integrate_f(0.0, 100.0, 500)
```

---

## Cython CMake
```{cmake}
project(CyPy)
enable_language(Fortran)
find_package(Python REQUIRED)
include(UseCython)

add_library(fwork SHARED
    fwork.f90
    fwork.h
    )
cython_add_module(pywork 
    pywork.pyx
    )
target_link_libraries(pywork
    fwork
    )
```

---

## Haskell
* FFI (Foreign Functions Interface):
    * Call C functions from Haskell
    * Export Haskell functions to C


