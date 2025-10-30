subroutine update_node_ID_by_subst_nID_list(mesh,subst_nID)
  use mod_parameters
  implicit none
  
  type(type_mesh), intent(inout) :: mesh
  integer, intent(in) :: subst_nID(mesh%nnode) !> 歯抜けが存在する
  
  !> 歯抜けなしの詰めた節点IDへの置換を保存する
  integer :: ncount
  integer, allocatable :: nodeID_list(:)
  !> 完全な置換リスト
  integer, allocatable :: entire_replacement_list(:)
  !> コピー用のmeshデータ
  type(type_mesh) :: mesh_t
  
  integer :: i, j
  
  allocate(nodeID_list(mesh%nnode))
  nodeID_list(:) = -1 !> -1にIDが置換された節点がいれば問題あり(debug用)
  ncount = 0
  do i=1, mesh%nnode
    if(i==subst_nID(i)) then !> 重複点が存在しないOR自身が保存される場合
      ncount = ncount + 1
      nodeID_list(i) = ncount
    end if
  end do
  
  !> nodeID_list(subst_nID)で置換することで，目的の置換が得られる
  allocate(entire_replacement_list(mesh%nnode))
  entire_replacement_list(:) = -1
  do i=1, mesh%nnode
    entire_replacement_list(i) = nodeID_list(subst_nID(i))
  end do
  
  !> メッシュを一時保存し，節点数を更新
  call copy_mesh_data(mesh,mesh_t)
  mesh%nnode = ncount
  
  !> 重複なしの節点数でallocateしなおす
  deallocate(mesh%node)
  allocate(mesh%node(mesh%dim,mesh%nnode))
  
  !> 節点を保存
  do i=1, mesh_t%nnode
    mesh%node(:,entire_replacement_list(i)) = mesh_t%node(:,i)
  end do
  
  !> 要素を更新
  do i=1, mesh%nelem
    do j=1, mesh%nbase_func
      mesh%elem(j,i) = entire_replacement_list(mesh%elem(j,i))
    end do
  end do
  
  
  write(*,*) 'nnode : ', mesh_t%nnode, ' -> ', mesh%nnode
  write(*,*) 'nelem : ', mesh_t%nelem, ' -> ', mesh%nelem
  
  
end subroutine