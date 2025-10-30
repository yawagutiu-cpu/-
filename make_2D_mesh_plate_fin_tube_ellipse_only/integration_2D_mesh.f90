subroutine integration_2D_mesh(plane,mesh)
  use mod_parameters
  implicit none
  type(type_mesh), intent(in) :: plane
  type(type_mesh), intent(inout) :: mesh
  
  integer :: ecount, ne_b
  integer :: ncount, nn_b
  
  integer :: i, j
  
  
  !> ���݂̐ߓ_�ԍ���ۑ�
  ncount = mesh%nnode
  ecount = mesh%nelem
  nn_b = ncount
  ne_b = ecount
  
  !> �ߓ_���A�v�f�����X�V
  ncount = ncount + plane%nnode
  ecount = ecount + plane%nelem
  
  call reallocate_mesh(mesh,ncount,ecount)  !> �f�[�^��ێ������܂܁C�ߓ_�C�v�f�̔z��̑傫����ύX
  
  do i=1, plane%nnode
    mesh%node(:,i+nn_b) = plane%node(:,i)
  end do
  do i=1, plane%nelem
    mesh%elem(:,i+ne_b) = plane%elem(:,i) + nn_b
    mesh%mat_id(i+ne_b) = plane%mat_id(i)
  end do
  
  write(*,*)
  write(*,*) '*add mesh'
  write(*,'(1a,1I0,1a,1I0,1a)') ' add  : nodes(',plane%nnode,') & elems(',plane%nelem,')'
  write(*,'(1a,1I0,1a,1I0,1a)') ' total: nodes(',mesh%nnode,') & elems(',mesh%nelem,')'
  
  
end subroutine