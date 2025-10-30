
subroutine find_minimum_inter_nodal_distance(mesh,delta)
  use mod_parameters
  implicit none
  type(type_mesh), intent(in) :: mesh  
  double precision, intent(out) :: delta
  double precision, allocatable :: node(:,:)
  double precision :: length
  double precision :: l
  
  integer :: i, j
  
  !> óvëfÇ≤Ç∆ÇÃç≈è¨êﬂì_ä‘ãóó£ÇãÅÇﬂÇÈ
  allocate(node(mesh%dim,mesh%nbase_func))
  do j=1, mesh%nbase_func
    node(:,j) = mesh%node(:,mesh%elem(j,1))
  end do
  call search_minimum_length_in_element(node,mesh%dim,mesh%nbase_func,length)
  
  do i=1, mesh%nelem
    do j=1, mesh%nbase_func
      node(:,j) = mesh%node(:,mesh%elem(j,i))
    end do
    call search_minimum_length_in_element(node,mesh%dim,mesh%nbase_func,l)
    if(l<length) then
      length = l
    end if
  end do
  
  delta = length
  
end subroutine
  
subroutine search_minimum_length_in_element(node,dim,nbase,length)
  implicit none
  integer, intent(in) :: dim, nbase
  double precision, intent(in) :: node(dim,nbase)
  double precision, intent(out) :: length
  double precision :: l
  
  integer :: i,j
  
  call compute_length(node(:,1),node(:,2),dim,length)
  do i=1, nbase-1
    do j=i+1, nbase
      call compute_length(node(:,i),node(:,j),dim,l)
      if(l<length) then
        length = l
      end if
    end do
  end do
  
end subroutine

subroutine compute_length(n1,n2,dim,l)
  implicit none
  integer, intent(in) :: dim
  double precision, intent(in) :: n1(dim), n2(dim)
  double precision, intent(out) :: l
  
  l = sqrt(dot_product(n1(:)-n2(:),n1(:)-n2(:)))
  
end subroutine