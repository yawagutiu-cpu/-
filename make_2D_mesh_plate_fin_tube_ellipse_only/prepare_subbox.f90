subroutine prepare_subbox(sys)
  use mod_parameters
  implicit none
  type(type_sys_subbox) :: sys
  
  sys%max_i(:) = sys%max_x(:) / sys%delta + 2
  sys%min_i(:) = sys%min_x(:) / sys%delta - 2
  
  write(*,*) 'sub box index'
  write(*,*) sys%max_i
  write(*,*) sys%min_i
  
  allocate( sys%box( &
    sys%min_i(1):sys%max_i(1), &
    sys%min_i(2):sys%max_i(2), &
    sys%min_i(3):sys%max_i(3)) )
  
  sys%box(:,:,:)%nnode = 0
  
end subroutine
