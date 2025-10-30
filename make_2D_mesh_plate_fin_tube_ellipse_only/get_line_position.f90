subroutine get_line_position(x_s,x_e,n,node)
  implicit none
  double precision, intent(in) :: x_s(3), x_e(3)
  integer, intent(in) :: n
  double precision, intent(inout) :: node(3,n+1)
  
  double precision :: dx(3), x(3)
  
  integer :: i, j
  
  dx(:) = (x_e(:) - x_s(:)) / dble(n)
  x(:) = x_s(:)
  
  do i=1, n+1
    node(:,i) = x(:)
    x(:) = x(:) + dx(:)
  end do
  
  write(*,*) '*get_line'
  write(*,*) ' subdiv = ', n
  write(*,*) x_s
  write(*,*) x_e
  write(*,*)
  
end subroutine