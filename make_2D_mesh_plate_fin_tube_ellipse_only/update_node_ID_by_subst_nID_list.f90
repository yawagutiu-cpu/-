subroutine update_node_ID_by_subst_nID_list(mesh,subst_nID)
  use mod_parameters
  implicit none
  
  type(type_mesh), intent(inout) :: mesh
  integer, intent(in) :: subst_nID(mesh%nnode) !> �����������݂���
  
  !> �������Ȃ��̋l�߂��ߓ_ID�ւ̒u����ۑ�����
  integer :: ncount
  integer, allocatable :: nodeID_list(:)
  !> ���S�Ȓu�����X�g
  integer, allocatable :: entire_replacement_list(:)
  !> �R�s�[�p��mesh�f�[�^
  type(type_mesh) :: mesh_t
  
  integer :: i, j
  
  allocate(nodeID_list(mesh%nnode))
  nodeID_list(:) = -1 !> -1��ID���u�����ꂽ�ߓ_������Ζ�肠��(debug�p)
  ncount = 0
  do i=1, mesh%nnode
    if(i==subst_nID(i)) then !> �d���_�����݂��Ȃ�OR���g���ۑ������ꍇ
      ncount = ncount + 1
      nodeID_list(i) = ncount
    end if
  end do
  
  !> nodeID_list(subst_nID)�Œu�����邱�ƂŁC�ړI�̒u����������
  allocate(entire_replacement_list(mesh%nnode))
  entire_replacement_list(:) = -1
  do i=1, mesh%nnode
    entire_replacement_list(i) = nodeID_list(subst_nID(i))
  end do
  
  !> ���b�V�����ꎞ�ۑ����C�ߓ_�����X�V
  call copy_mesh_data(mesh,mesh_t)
  mesh%nnode = ncount
  
  !> �d���Ȃ��̐ߓ_����allocate���Ȃ���
  deallocate(mesh%node)
  allocate(mesh%node(mesh%dim,mesh%nnode))
  
  !> �ߓ_��ۑ�
  do i=1, mesh_t%nnode
    mesh%node(:,entire_replacement_list(i)) = mesh_t%node(:,i)
  end do
  
  !> �v�f���X�V
  do i=1, mesh%nelem
    do j=1, mesh%nbase_func
      mesh%elem(j,i) = entire_replacement_list(mesh%elem(j,i))
    end do
  end do
  
  
  write(*,*) 'nnode : ', mesh_t%nnode, ' -> ', mesh%nnode
  write(*,*) 'nelem : ', mesh_t%nelem, ' -> ', mesh%nelem
  
  
end subroutine