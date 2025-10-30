subroutine initialize_mesh_square(mesh)
  use mod_parameters
  implicit none
  
  type(type_mesh), intent(inout) :: mesh
  
  
  mesh%mesh_type = 9
  mesh%dim = 3
  mesh%nnode = 0
  mesh%nelem = 0
  mesh%nbase_func = 4 !> ˆêŠiŽq“àß“_”
  call deallocate_mesh(mesh)
  
end subroutine initialize_mesh_square

subroutine initialize_mesh_hex(mesh)
  use mod_parameters
  implicit none
  
  type(type_mesh), intent(inout) :: mesh
  
  
  mesh%mesh_type = 12
  mesh%dim = 3
  mesh%nnode = 0
  mesh%nelem = 0
  mesh%nbase_func = 8 !> ˆêŠiŽq“àß“_”
  call deallocate_mesh(mesh)
  
end subroutine  initialize_mesh_hex
  
subroutine deallocate_mesh(mesh)
  use mod_parameters
  implicit none
  
  type(type_mesh), intent(inout) :: mesh
  if(allocated(mesh%node)) deallocate(mesh%node)
  if(allocated(mesh%elem)) deallocate(mesh%elem)
  if(allocated(mesh%mat_id)) deallocate(mesh%mat_id)
  
end subroutine deallocate_mesh
  
subroutine allocate_mesh(mesh)
  use mod_parameters
  implicit none
  
  type(type_mesh), intent(inout) :: mesh
  allocate(mesh%node(mesh%dim,mesh%nnode))
  allocate(mesh%elem(mesh%nbase_func,mesh%nelem))
  allocate(mesh%mat_id(mesh%nelem))
  mesh%node(:,:) = 0.0d0
  mesh%elem(:,:) = 0
  mesh%mat_id(:) = 0
end subroutine allocate_mesh
  
subroutine copy_mesh_data(mesh,mesh_copy)
  use mod_parameters
  implicit none
  type(type_mesh), intent(in) :: mesh
  type(type_mesh), intent(out) :: mesh_copy
  
  integer :: i, j
  
  mesh_copy%mesh_type = mesh%mesh_type
  mesh_copy%dim = mesh%dim
  mesh_copy%nnode = mesh%nnode
  mesh_copy%nelem = mesh%nelem
  mesh_copy%nbase_func = mesh%nbase_func
  
  call allocate_mesh(mesh_copy)
  forall(i=1:mesh_copy%nnode,j=1:mesh_copy%dim)
    mesh_copy%node(j,i) = mesh%node(j,i)
  end forall
  if(mesh%nelem /= 0) then
    mesh_copy%elem(:,:) = mesh%elem(:,:)
    mesh_copy%mat_id(:) = mesh%mat_id(:)
  end if
end subroutine
  
subroutine reallocate_mesh(mesh,nnode,nelem)
  use mod_parameters
  implicit none
  
  integer, intent(in) :: nnode, nelem
  type(type_mesh), intent(inout) :: mesh
  type(type_mesh) :: mesh_t
  integer :: i
  
  call copy_mesh_data(mesh,mesh_t)
  call deallocate_mesh(mesh)
  mesh%nnode = nnode
  mesh%nelem = nelem
  call allocate_mesh(mesh)
  
  
  if(mesh%nnode > mesh_t%nnode) then
    mesh%node(:,1:mesh_t%nnode) = mesh_t%node(:,1:mesh_t%nnode)
  else
    mesh%node(:,1:mesh%nnode) = mesh_t%node(:,1:mesh%nnode)
  end if
  
  if(mesh%nelem > mesh_t%nelem) then
    mesh%elem(:,1:mesh_t%nelem) = mesh_t%elem(:,1:mesh_t%nelem)
    mesh%mat_id(1:mesh_t%nelem) = mesh_t%mat_id(1:mesh_t%nelem)
  else
    mesh%elem(:,1:mesh%nelem) = mesh_t%elem(:,1:mesh%nelem)
    mesh%mat_id(1:mesh%nelem) = mesh_t%mat_id(1:mesh%nelem)
  end if
  
  call deallocate_mesh(mesh_t)
end subroutine  