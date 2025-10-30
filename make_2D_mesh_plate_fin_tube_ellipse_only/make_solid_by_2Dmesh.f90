subroutine make_solid_by_2Dmesh(solid,mesh_2D,t_m,t_p,delta_t)
  use mod_parameters
  implicit none
  type(type_mesh), intent(in) :: mesh_2D
  type(type_mesh), intent(inout) :: solid
  double precision, intent(in) :: t_m, t_p, delta_t
  
  
  !> 分割数(要素数)
  integer :: n_sub
  
  double precision :: z !> 高さ方向
  integer :: nodeID, elemID
  integer :: i,j,k
  
  write(*,*) 
  write(*,*) '======================================================================'
  write(*,*) '| make_solid_by_2Dmesh '
  write(*,*) '| 3D mesh extrusion based on 2D mesh.'
  write(*,*) '----------------------------------------------------------------------'
  
  
  n_sub = (t_p - t_m) / delta_t
  write(*,*) '| delta       : ', delta_t
  write(*,*) '| extrusion   : ', t_m, ' -> ', t_p
  write(*,*) '| subdivision : ', n_sub
  
  !> ソリッドデータのメッシュを確保
  solid%nnode = mesh_2D%nnode * (n_sub + 1)
  solid%nelem = mesh_2D%nelem * n_sub
  call allocate_mesh(solid)
  
  write(*,*) '| nnode       : ', solid%nnode
  write(*,*) '| nelem       : ', solid%nelem
  
  !> 節点座標の取得
  z = t_m
  do i=0, n_sub
    z = delta_t * dble(i) + t_m
    do j=1, mesh_2D%nnode
      nodeID = i*mesh_2D%nnode + j
      solid%node(1:2,nodeID) = mesh_2D%node(1:2,j)
      solid%node(3:3,nodeID) = mesh_2D%node(3:3,j) + z
    end do
  end do
  
  !> 要素情報の取得
  elemID = 0
  do i=0, n_sub - 1
    do j=1, mesh_2D%nelem
      elemID = elemID + 1
      do k=1, mesh_2D%nbase_func
        solid%elem(k,elemID) = mesh_2D%elem(k,j) + mesh_2D%nnode * i
        solid%elem(k+mesh_2D%nbase_func,elemID) = mesh_2D%elem(k,j) + mesh_2D%nnode * (i+1)
      end do
      solid%mat_id(elemID) = mesh_2D%mat_id(j)
    end do
  end do
  
  
  write(*,*) '| Finish make_solid_by_2Dmesh '
  write(*,*) '----------------------------------------------------------------------'
  
end subroutine