subroutine search_duplicate_make_subst_list(dim,nnode,node,sys,subst_nID,delta)
  use mod_parameters
  implicit none
  integer, intent(in) :: dim, nnode
  double precision, intent(in) :: node(dim,nnode), delta
  type(type_sys_subbox), intent(in) :: sys
  integer, intent(inout) :: subst_nID(nnode)
  
  integer :: x_i(3)
  integer :: i, j, k, l, m
  
  double precision :: x1(3), x2(3)
  double precision :: length
  
  do i=1, nnode
    x1(:) = node(:,i)
    x_i(:) = node(:,i) / sys%delta
    do j=x_i(1)-1,x_i(1)+1
      do k=x_i(2)-1,x_i(2)+1
        do l=x_i(3)-1,x_i(3)+1
          do m=1, sys%box(j,k,l)%nnode
            x2(:) = node(:,sys%box(j,k,l)%nID(m))
            call compute_length(x1,x2,dim,length)
            if(length < delta) then
              if(subst_nID(i)<sys%box(j,k,l)%nID(m)) then
                subst_nID(sys%box(j,k,l)%nID(m)) = subst_nID(i)
              else
                subst_nID(i) = sys%box(j,k,l)%nID(m)
              end if
            end if
          end do
        end do
      end do
    end do
  end do
  
  
end subroutine