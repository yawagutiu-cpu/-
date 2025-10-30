subroutine output_mesh_paraview(mesh,fname)
  use mod_parameters
  implicit none
  type(type_mesh), intent(in) :: mesh
  character(*), intent(in) :: fname
  
  call output_paraview &
    (mesh%dim,mesh%nnode,mesh%nbase_func,mesh%nelem,mesh%node,mesh%elem&
    ,mesh%mat_id,mesh%mesh_type,fname)
  
end subroutine