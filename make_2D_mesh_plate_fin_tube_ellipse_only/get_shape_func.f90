subroutine get_shape_func(shape_func,n1,n3)
  implicit none
  integer, intent(in) :: n1, n3
  double precision, intent(inout) :: shape_func(4,n1,n3)
  
  integer :: i, j
  double precision :: delta_xi(2)
  double precision, allocatable :: xi(:)
  double precision, allocatable :: eta(:)
  
  allocate(xi(n1))
  allocate(eta(n3))
  
  delta_xi(1) = 2.0d0 / dble(n1-1)
  delta_xi(2) = 2.0d0 / dble(n3-1)
  
  do i=1, n1
    xi(i) = -1.0d0 + delta_xi(1) * dble(i-1)
  end do
  
  do i=1, n3
    eta(i) = -1.0d0 + delta_xi(2) * dble(i-1)
  end do
  
  do i=1, n1
    do j=1, n3
      shape_func(1,i,j) = (1.0d0 - xi(i)) * (1.0d0 - eta(j)) / 4.0d0
      shape_func(2,i,j) = (1.0d0 + xi(i)) * (1.0d0 - eta(j)) / 4.0d0
      shape_func(3,i,j) = (1.0d0 + xi(i)) * (1.0d0 + eta(j)) / 4.0d0
      shape_func(4,i,j) = (1.0d0 - xi(i)) * (1.0d0 + eta(j)) / 4.0d0
    end do
  end do
  
end subroutine