subroutine integration_3D_mesh(part,mesh)
  use mod_parameters
  implicit none
  type(type_mesh), intent(in) :: part
  type(type_mesh), intent(inout) :: mesh
  
  integer :: ecount, ne_b
  integer :: ncount, nn_b
  
  integer :: i, j
  
  
  !> 現在の節点番号を保存
  ncount = mesh%nnode
  ecount = mesh%nelem
  nn_b = ncount
  ne_b = ecount
  
  !> 節点数、要素数を更新
  ncount = ncount + part%nnode
  ecount = ecount + part%nelem
  
  call reallocate_mesh(mesh,ncount,ecount)  !> データを保持したまま，節点，要素の配列の大きさを変更
  
  do i=1, part%nnode
    mesh%node(:,i+nn_b) = part%node(:,i)
  end do
  do i=1, part%nelem
    mesh%elem(:,i+ne_b) = part%elem(:,i) + nn_b
    mesh%mat_id(i+ne_b) = part%mat_id(i)
  end do
  
  write(*,*)
  write(*,*) '*add mesh'
  write(*,'(1a,1I0,1a,1I0,1a)') ' add  : nodes(',part%nnode,') & elems(',part%nelem,')'
  write(*,'(1a,1I0,1a,1I0,1a)') ' total: nodes(',mesh%nnode,') & elems(',mesh%nelem,')'
  
  
end subroutine