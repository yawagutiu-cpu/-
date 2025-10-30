subroutine search_max_min_nodes(dim,nnode,node,max_x,min_x)
  implicit none
  integer, intent(in) :: dim, nnode
  double precision, intent(in) :: node(dim,nnode)
  double precision, intent(out) :: max_x(dim), min_x(dim)
  
  integer :: i
  do i=1, dim
    max_x(i) = maxval(node(i,:))
    min_x(i) = minval(node(i,:))
  end do
  
  write(*,'(1a,3F20.10)') ' max : ', max_x(:)
  write(*,'(1a,3F20.10)') ' min : ', min_x(:)
  
end subroutine