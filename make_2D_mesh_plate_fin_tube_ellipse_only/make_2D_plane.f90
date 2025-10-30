subroutine make_2D_plane(edge,plane,mat_id)
  use mod_parameters
  implicit none
  type(type_edge), intent(in) :: edge
  integer, intent(in) :: mat_id
  type(type_mesh), intent(out) :: plane
  
  integer :: n(4)
  integer :: i
  integer :: nnode, nelem
  double precision :: x_p(3,4)  !> 角の点の座標を保存
  
  !> エッジデータをもとに構造格子でメッシュを切ります
  
  write(*,*) ' *make_2D_plane_by_edge'
  
  plane%mesh_type = 9
  plane%dim = 3
  plane%nbase_func = 4
  
  do i=1, 4
    n(i) = edge%curve(i)%nnode
  end do
  
  if(n(1) /= n(2) .OR. n(3) /= n(4)) then
    write(*,*) ' error structural lattice :number of divisions'
    write(*,'(4I10)') n(:)
  end if
  
  !> 構造格子なので単純に節点数要素数は設定される
  nnode = n(1) * n(3)
  nelem = (n(1)-1) * (n(3)-1)
  plane%nnode = nnode
  plane%nelem = nelem
  
  allocate(plane%node(plane%dim,nnode))
  allocate(plane%elem(plane%nbase_func,nelem))
  allocate(plane%mat_id(plane%nelem))
  plane%node = 0.0d0
  plane%elem = 0
  plane%mat_id(:) = mat_id
  
  !> 角の点を保存
  x_p(:,:) = 0.0d0
  x_p(:,1) = edge%curve(1)%node(:,1)
  x_p(:,2) = edge%curve(1)%node(:,edge%curve(1)%nnode)
  x_p(:,3) = edge%curve(2)%node(:,edge%curve(2)%nnode)
  x_p(:,4) = edge%curve(2)%node(:,1)
  
  !> 角の4点を元に構造格子を各辺を直線で作成
  call make_structural_lattice(plane,x_p,n(1),n(3))
  
  !> 4本のエッジデータに添うように構造格子の座標を補正
  call correct_structural_lattices_with_edge(edge,plane)
  
end subroutine make_2D_plane