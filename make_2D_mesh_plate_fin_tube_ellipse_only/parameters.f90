module mod_parameters
  implicit none
  
  double precision, parameter :: pi = 3.141592653589d0
  
  integer :: flag_debug_input
  
  !> 2D
  double precision :: Lx !> フィン横幅
  double precision :: Ly !> フィン縦幅
  integer :: nx !> 横分割数
  integer :: ny !> 縦分割数
  integer :: nfin !> フィン分割数
  double precision :: x_R !> 楕円中心 x座標
  double precision :: y_R !> 楕円中心 y座標
  double precision :: Ra !> 楕円x方向径
  double precision :: Rb !> 楕円y方向径, 分割数はnx, nyで固定される
  double precision :: Rt !> 楕円肉厚
  integer :: nR !> 楕円径方向分割数
  
  !> 3D
  double precision :: t_fin_m
  double precision :: t_fin_p
  double precision :: t_tube_m
  double precision :: t_tube_p
  double precision :: t_mesh
  
  
  type type_mesh
    !> 六面体:12, 線:3, 四角:9
    integer :: mesh_type = 12
    !> 座標系の次元
    integer :: dim = 3
    !> 節点数
    integer :: nnode
    !> 節点座標
    double precision, allocatable :: node(:,:)
    !> 要素数
    integer :: nelem
    !> 要素を構成する節点数
    integer :: nbase_func
    !> 要素
    integer, allocatable :: elem(:,:)
    !> 材料番号
    integer, allocatable :: mat_id(:)
  end type
  
  !> エッジ,曲線上の節点を保存
  type type_curve
    integer :: dim = 3
    integer :: nnode
    double precision, allocatable :: node(:,:)
  end type
  
  !> 四角形を構成する4つのエッジを保存
  type type_edge
    type(type_curve) :: curve(4)
    !> 1-2, 4-3, 1-4, 2-3の辺の順番で保存する
  end type
  
  !> 節点探索用のサブ格子
  type type_subbox
    integer :: nnode
    integer, allocatable :: nID(:)
  end type
  type type_sys_subbox
    double precision :: delta
    double precision :: max_x(3), min_x(3)
    integer :: max_i(3), min_i(3)
    type(type_subbox), allocatable :: box(:,:,:)
  end type
  
end module