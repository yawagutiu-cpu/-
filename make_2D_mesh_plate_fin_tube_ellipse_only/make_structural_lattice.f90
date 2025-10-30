subroutine make_structural_lattice(plane,x_p,n1,n3)
  use mod_parameters
  implicit none
  type(type_mesh), intent(inout) :: plane
  integer, intent(in) :: n1, n3
  double precision, intent(in) :: x_p(3,4)
  
  double precision, allocatable :: shape_func(:,:,:)
  integer :: ncount, ecount
  integer :: nID
  integer :: i, j, k
  
  allocate(shape_func(4,n1,n3))
  
  !> Œ`óŠÖ”‚ğæ“¾
  call get_shape_func(shape_func,n1,n3)
  
  plane%node = 0.0d0
  ncount = 0
  ecount = 0
  do i=1, n1
    do j=1, n3
      nID = (i-1) * n3 + j
      do k=1, 4
        plane%node(:,nID) = plane%node(:,nID) + shape_func(k,i,j) * x_p(:,k)
      end do
      if(i<n1 .and. j<n3) then
        ecount = ecount + 1
        plane%elem(1,ecount) = nID
        plane%elem(2,ecount) = nID + n3
        plane%elem(3,ecount) = nID + n3 + 1
        plane%elem(4,ecount) = nID + 1
      end if
    end do
  end do
  
end subroutine