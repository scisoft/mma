.. role:: cover

============================================
:cover:`Mixed Martial Arts`
============================================

.. class:: cover

    ::

        Jonas Juselius <jonas.juselius@uit.no>
        HPC@UiT

.. raw:: pdf

   SetPageCounter 0
   Transition Dissolve 1
   PageBreak oneColumn

Why
--------------------------------------------
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

How
--------------------------------------------
* C is the common denominator
* Export needed functionality to C
* Often necessary to modularize the host code:
    * init()
    * step()
    * finalize()
    * \+ accessors
* Couple either directly or via Cython
* Use CMake to build and link

Fortran
-------------------------------------------
* Use iso_c_binding
* Calling conventions:
    * Pass by value
    * bind(C)
    * c_ptr, c_loc, c_f_pointer
    * Column vs. row major matrices

Fortran calling C
-------------------------------------------
.. code-block:: Fortran
    :include: code/ccall.f90

C calling Fortran
-------------------------------------------
.. code-block:: Fortran
    :include: code/fwork.f90

.. code-block:: C
    :include: code/fcall.c

C++
-------------------------------------------
C++ cannot be directly linked due to name mangling.

.. code-block:: C++
    :include: code/classy.h

Cython
-------------------------------------------
* Compile Python to C!
    * Speedup Pyhton
    * Call external C/C++ functions directly
    * Pass arrays via numpy
    * Use CMake!

* https://github.com/bakerjonas/python-tutorials/tree/master/Cython

Cython for speed
------------------------------------------
.. code-block:: cython
    :include: code/cyspeed.pyx

Cython calling C
------------------------------------------
.. code-block:: cython
    :include: code/pywork.pyx

Calling Cython from Python
------------------------------------------
.. code-block:: cython
    :include: code/cypy.py

Cython CMake
------------------------------------------
.. code-block:: cmake
    :include: code/CMakeLists.cython


Haskell
-------------------------------------------
* FFI (Foreign Functions Interface):
    * Call C functions from Haskell
    * Export Haskell functions to C


