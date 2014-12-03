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
