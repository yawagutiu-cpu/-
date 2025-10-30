subroutine store_nodeID_to_subbox(dim,nnode,node,sys_box)
  use mod_parameters
  implicit none
  integer, intent(in) :: dim, nnode
  double precision, intent(in) :: node(dim,nnode)
  type(type_sys_subbox) :: sys_box
  
  double precision :: delta
  
  integer :: x_i(3)
  integer :: i, j, k
  
  delta = sys_box%delta
  
  !> äiéqì‡êﬂì_ÇÉJÉEÉìÉg
  do i=1, nnode
    x_i(:) = node(:,i) / delta
    sys_box%box(x_i(1),x_i(2),x_i(3))%nnode = &
      sys_box%box(x_i(1),x_i(2),x_i(3))%nnode + 1
  end do
  
  !> äiéqì‡êﬂì_ÇÃIDÇäiî[Ç∑ÇÈîzóÒÇämï€
  do i=sys_box%min_i(1), sys_box%max_i(1)
  do j=sys_box%min_i(2), sys_box%max_i(2)
  do k=sys_box%min_i(3), sys_box%max_i(3)
    allocate(sys_box%box(i,j,k)%nID(sys_box%box(i,j,k)%nnode))
  end do
  end do
  end do
  
  !> äiéqì‡êﬂì_ÇÃIDÇäiî[
  sys_box%box(:,:,:)%nnode = 0
  do i=1, nnode
    x_i(:) = node(:,i) / delta
    sys_box%box(x_i(1),x_i(2),x_i(3))%nnode = &
      sys_box%box(x_i(1),x_i(2),x_i(3))%nnode + 1
    sys_box%box(x_i(1),x_i(2),x_i(3))% &
      nID(sys_box%box(x_i(1),x_i(2),x_i(3))%nnode) = i
  end do
  
end subroutine