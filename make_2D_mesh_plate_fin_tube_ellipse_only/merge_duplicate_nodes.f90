subroutine merge_duplicate_nodes(mesh)
  use mod_parameters
  implicit none
  type(type_mesh), intent(inout) :: mesh
  type(type_sys_subbox) :: sys_subbox
  
  double precision :: delta !> �ߓ_�Ԃ̍ŏ�������ۑ�����
  integer, allocatable :: subst_nID(:)
  
  integer :: i
  
  !>---------------------------------------
  !> �d�����Ă���_���}�[�W���邱�Ƃ�ڎw��
  !>---------------------------------------
  write(*,*) 
  write(*,*) '======================================================================'
  write(*,*) ' merge_duplicate_nodes'
  write(*,*) '----------------------------------------------------------------------'
  call find_minimum_inter_nodal_distance(mesh,delta)
  write(*,*) ' Minimum distance between nodes : ', delta
  sys_subbox%delta = delta  !> �T���̈�̑傫��������
  delta = delta / 10.0d0
  write(*,*) ' Merging distance               : ', delta
  
  !> �S�ߓ_�̍ő�ŏ��̍��W�l�����߂�
  call search_max_min_nodes&
    (mesh%dim,mesh%nnode,mesh%node,sys_subbox%max_x,sys_subbox%min_x)
  
  
  !> �T�������������邽�߂ɐߓ_ID���T�u�i�q���ɕۑ�����
  call prepare_subbox(sys_subbox)
  call store_nodeID_to_subbox(mesh%dim,mesh%nnode,mesh%node,sys_subbox)
  
  !> �ߓ_ID�̒u�����X�g�𐶐�����
  allocate(subst_nID(mesh%nnode))
  forall(i=1:mesh%nnode) subst_nID(i) = i !> �P���u���ŏ�����
  
  !> �T�u�i�q�𗘗p���ďd���ߓ_��T��
  !> �d���_�ɂ����Ēu�����X�g�͎Ⴂ�l�ɃV�t�g��������ō��킹��
  call search_duplicate_make_subst_list&
    (mesh%dim,mesh%nnode,mesh%node,sys_subbox,subst_nID,delta)
  
  !> �u�����X�g�������Ƀ��b�V�����č\�z
  call update_node_ID_by_subst_nID_list(mesh,subst_nID)
  
  write(*,*) ' *finish_merge_duplicate_nodes'
  write(*,*) '----------------------------------------------------------------------'
  write(*,*) 
  
end subroutine
