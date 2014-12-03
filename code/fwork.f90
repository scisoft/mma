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
