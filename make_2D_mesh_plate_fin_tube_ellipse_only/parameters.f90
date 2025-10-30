module mod_parameters
  implicit none
  
  double precision, parameter :: pi = 3.141592653589d0
  
  integer :: flag_debug_input
  
  !> 2D
  double precision :: Lx !> �t�B������
  double precision :: Ly !> �t�B���c��
  integer :: nx !> ��������
  integer :: ny !> �c������
  integer :: nfin !> �t�B��������
  double precision :: x_R !> �ȉ~���S x���W
  double precision :: y_R !> �ȉ~���S y���W
  double precision :: Ra !> �ȉ~x�����a
  double precision :: Rb !> �ȉ~y�����a, ��������nx, ny�ŌŒ肳���
  double precision :: Rt !> �ȉ~����
  integer :: nR !> �ȉ~�a����������
  
  !> 3D
  double precision :: t_fin_m
  double precision :: t_fin_p
  double precision :: t_tube_m
  double precision :: t_tube_p
  double precision :: t_mesh
  
  
  type type_mesh
    !> �Z�ʑ�:12, ��:3, �l�p:9
    integer :: mesh_type = 12
    !> ���W�n�̎���
    integer :: dim = 3
    !> �ߓ_��
    integer :: nnode
    !> �ߓ_���W
    double precision, allocatable :: node(:,:)
    !> �v�f��
    integer :: nelem
    !> �v�f���\������ߓ_��
    integer :: nbase_func
    !> �v�f
    integer, allocatable :: elem(:,:)
    !> �ޗ��ԍ�
    integer, allocatable :: mat_id(:)
  end type
  
  !> �G�b�W,�Ȑ���̐ߓ_��ۑ�
  type type_curve
    integer :: dim = 3
    integer :: nnode
    double precision, allocatable :: node(:,:)
  end type
  
  !> �l�p�`���\������4�̃G�b�W��ۑ�
  type type_edge
    type(type_curve) :: curve(4)
    !> 1-2, 4-3, 1-4, 2-3�̕ӂ̏��Ԃŕۑ�����
  end type
  
  !> �ߓ_�T���p�̃T�u�i�q
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