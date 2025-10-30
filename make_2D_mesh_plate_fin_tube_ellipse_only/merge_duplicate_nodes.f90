subroutine merge_duplicate_nodes(mesh)
  use mod_parameters
  implicit none
  type(type_mesh), intent(inout) :: mesh
  type(type_sys_subbox) :: sys_subbox
  
  double precision :: delta !> 節点間の最小距離を保存する
  integer, allocatable :: subst_nID(:)
  
  integer :: i
  
  !>---------------------------------------
  !> 重複している点をマージすることを目指す
  !>---------------------------------------
  write(*,*) 
  write(*,*) '======================================================================'
  write(*,*) ' merge_duplicate_nodes'
  write(*,*) '----------------------------------------------------------------------'
  call find_minimum_inter_nodal_distance(mesh,delta)
  write(*,*) ' Minimum distance between nodes : ', delta
  sys_subbox%delta = delta  !> 探索領域の大きさを決定
  delta = delta / 10.0d0
  write(*,*) ' Merging distance               : ', delta
  
  !> 全節点の最大最小の座標値を求める
  call search_max_min_nodes&
    (mesh%dim,mesh%nnode,mesh%node,sys_subbox%max_x,sys_subbox%min_x)
  
  
  !> 探索効率をあげるために節点IDをサブ格子内に保存する
  call prepare_subbox(sys_subbox)
  call store_nodeID_to_subbox(mesh%dim,mesh%nnode,mesh%node,sys_subbox)
  
  !> 節点IDの置換リストを生成する
  allocate(subst_nID(mesh%nnode))
  forall(i=1:mesh%nnode) subst_nID(i) = i !> 恒等置換で初期化
  
  !> サブ格子を利用して重複節点を探索
  !> 重複点において置換リストは若い値にシフトする方向で合わせる
  call search_duplicate_make_subst_list&
    (mesh%dim,mesh%nnode,mesh%node,sys_subbox,subst_nID,delta)
  
  !> 置換リストを根拠にメッシュを再構築
  call update_node_ID_by_subst_nID_list(mesh,subst_nID)
  
  write(*,*) ' *finish_merge_duplicate_nodes'
  write(*,*) '----------------------------------------------------------------------'
  write(*,*) 
  
end subroutine
