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

