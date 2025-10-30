!  make_2D_mesh_plate_fin_tube_ellipse_only.f90 
!
!  �֐�:
!  make_2D_mesh_plate_fin_tube_ellipse_only - �R���\�[���E�A�v���P�[�V�����̃G���g���[�|�C���g�B
!

!****************************************************************************
!
!  �v���O����: make_2D_mesh_plate_fin_tube_ellipse_only
!
!  �ړI:  �R���\�[���E�A�v���P�[�V�����̃G���g���[�|�C���g�B
!
!****************************************************************************

    program make_2D_mesh_plate_fin_tube_ellipse_only

    use mod_parameters
    implicit none

    ! �ϐ�
    type(type_edge) :: edge_tube(4), edge_fin(4)  !> tube��fin��4�̃G�b�W�ɕ������č쐬
    type(type_mesh) :: plane(2,4)      !> ���ʃf�[�^�̃��b�V��
    type(type_mesh) :: mesh_2D         !> plane�̖ʃf�[�^��S�Ă܂Ƃ߂����b�V���f�[�^
    type(type_mesh) :: mesh_2D_tube, mesh_2D_fin !> ���ꂼ��̗v�f���Ƃ�2D���b�V��
    type(type_mesh) :: solid_tube, solid_fin     !> �\���b�h�f�[�^
    type(type_mesh) :: solid
    integer :: i,j
    
    ! make_2D_mesh_plate_fin_tube_ellipse_only �̖{��
    !> �f�[�^�̓ǂݍ���
    call input
    !> �o�͐�̃f�B���N�g�����쐬
    call system('mkdir output')
    !> �G�b�W�f�[�^�̍쐬 (�G�b�W�f�[�^���R�[�h�Ŋ撣���č��K�v������)
    call make_2D_edge(edge_tube,edge_fin)
    call output_paraview_edge(edge_tube,edge_fin) !> �m�F�p
    
    !> �ȍ~�͊�{�I�ɘg�g�݂𗘗p���ă��b�V���𐶐��ł���
    !> �ʃf�[�^�̍쐬
    do i=1, 4
      call make_2D_plane(edge_tube(i),plane(1,i),1)
      call make_2D_plane(edge_fin(i),plane(2,i),2)
    end do
    
    !> �v�f���Ƃ�2D���b�V���̍쐬
    call initialize_mesh_square(mesh_2D_tube)
    call initialize_mesh_square(mesh_2D_fin)
    do i=1, 4
      call integration_2D_mesh(plane(1,i),mesh_2D_tube)
    end do
    do i=1, 4
      call integration_2D_mesh(plane(2,i),mesh_2D_fin)
    end do
    call merge_duplicate_nodes(mesh_2D_tube)
    call merge_duplicate_nodes(mesh_2D_fin)
    
    !> �ʃf�[�^���W�߂�
    call initialize_mesh_square(mesh_2D)
    !do i=1, 4
    !  do j=1, 2
    !    call integration_2D_mesh(plane(j,i),mesh_2D)
    !  end do
    !end do
    call integration_2D_mesh(mesh_2D_tube,mesh_2D)
    call integration_2D_mesh(mesh_2D_fin,mesh_2D)
    call output_mesh_paraview(mesh_2D,'integration_of_mesh_2D.vtu')
    
    !> �ʃf�[�^�̏d���_���}�[�W����
    call merge_duplicate_nodes(mesh_2D)
    call output_mesh_paraview(mesh_2D,'after_merge_mesh_2D.vtu')
    
    !> �S�̂�2D���b�V���������܂łŊ���
    
    
    !> �ʃf�[�^����\���b�h�f�[�^���쐬����
    call initialize_mesh_hex(solid_tube)
    call initialize_mesh_hex(solid_fin)
    
    call make_solid_by_2Dmesh&
      (solid_tube,mesh_2D_tube,t_tube_m,t_tube_p,t_mesh)
    call make_solid_by_2Dmesh&
      (solid_fin,mesh_2D_fin,t_fin_m,t_fin_p,t_mesh)
    
    !> �S�̃��b�V���𓝍�
    call initialize_mesh_hex(solid)
    call integration_3D_mesh(solid_tube,solid)
    call integration_3D_mesh(solid_fin ,solid)
    
    !> �d���ߓ_���폜
    call merge_duplicate_nodes(solid)
    
    !> �\���b�h�f�[�^�̏o��
    call output_mesh_paraview(solid,'solid.vtu')
    call system('mkdir solid')
    call output_mesh_data(solid,'solid')
    
    print *
    print *, ' Finish : All Sections! '

    end program make_2D_mesh_plate_fin_tube_ellipse_only

