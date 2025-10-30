subroutine correct_structural_lattices_with_edge(edge,plane)
  use mod_parameters
  implicit none
  type(type_edge), intent(in) :: edge
  type(type_mesh), intent(inout) :: plane
  
  integer :: count=0
  character(10) :: c
  character(50) :: fname, fname_pvtu
  integer :: fio_pvtu
  integer :: n1, n3
  integer :: n_index
  integer, allocatable :: nID(:)
  double precision, allocatable :: diff(:,:)
  double precision :: weight
  integer :: i,j,k
  
  n1 = edge%curve(1)%nnode
  n3 = edge%curve(3)%nnode
  !> ---------------------------------------
  !> ��1-2�Ƃ̍�������ߓ_���W��␳
  !> ---------------------------------------
  
  allocate(diff(3,n1))
  allocate(nID(n1))
  !> �[�̐ߓ_�ԍ����擾
  do i=1, n1
    nID(i) = (i-1) * n3 + 1
  end do
  !> �[�̐��ł̍���(�␳��)���v�Z
  diff(:,:) = 0.0d0
  do i=1, n1
    diff(:,i) = plane%node(:,nID(i)) - edge%curve(1)%node(:,i)
  end do
  !> �G�b�W�ɋ߂����ŏd��1,���΂ŏd��0�Őߓ_���W��␳
  do i=1, n1
    do j=1, n3
      n_index = (i-1)*n3 + j
      weight = dble(n3-j) / dble(n3-1)
      plane%node(:,n_index) = plane%node(:,n_index) - weight * diff(:,i)
    end do
  end do
  deallocate(nID)
  deallocate(diff)
  
  !> ---------------------------------------
  !> ��3-4�Ƃ̍�������ߓ_���W��␳
  !> ---------------------------------------
  allocate(diff(3,n1))
  allocate(nID(n1))
  !> �[�̐ߓ_�ԍ����擾
  do i=1, n1
    nID(i) = (i-1) * n3 + n3
  end do
  !> �[�̐��ł̍���(�␳��)���v�Z
  diff(:,:) = 0.0d0
  do i=1, n1
    diff(:,i) = plane%node(:,nID(i)) - edge%curve(2)%node(:,i)
  end do
  !> �G�b�W�ɋ߂����ŏd��1,���΂ŏd��0�Őߓ_���W��␳
  do i=1, n1
    do j=1, n3
      n_index = (i-1)*n3 + j
      weight = dble(j-1) / dble(n3-1)
      plane%node(:,n_index) = plane%node(:,n_index) - weight * diff(:,i)
    end do
  end do
  
  deallocate(nID)
  deallocate(diff)
  
  !> ---------------------------------------
  !> ��1-4�Ƃ̍�������ߓ_���W��␳
  !> ---------------------------------------
  allocate(diff(3,n3))
  allocate(nID(n3))
  !> �[�̐ߓ_�ԍ����擾
  do i=1, n3
    nID(i) = i
  end do
  !> �[�̐��ł̍���(�␳��)���v�Z
  diff(:,:) = 0.0d0
  do i=1, n3
    diff(:,i) = plane%node(:,nID(i)) - edge%curve(3)%node(:,i)
  end do
  !> �G�b�W�ɋ߂����ŏd��1,���΂ŏd��0�Őߓ_���W��␳
  do i=1, n1
    do j=1, n3
      n_index = (i-1)*n3 + j
      weight = dble(i-1) / dble(n1-1)
      plane%node(:,n_index) = plane%node(:,n_index) - weight * diff(:,j)
    end do
  end do
  
  deallocate(nID)
  deallocate(diff)
  
  !> ---------------------------------------
  !> ��2-3�Ƃ̍�������ߓ_���W��␳
  !> ---------------------------------------
  allocate(diff(3,n3))
  allocate(nID(n3))
  !> �[�̐ߓ_�ԍ����擾
  do i=1, n3
    nID(i) = i + (n1-1)*n3
  end do
  !> �[�̐��ł̍���(�␳��)���v�Z
  diff(:,:) = 0.0d0
  do i=1, n3
    diff(:,i) = plane%node(:,nID(i)) - edge%curve(4)%node(:,i)
  end do
  !> �G�b�W�ɋ߂����ŏd��1,���΂ŏd��0�Őߓ_���W��␳
  do i=1, n1
    do j=1, n3
      n_index = (i-1)*n3 + j
      weight = dble(i-1) / dble(n1-1)
      plane%node(:,n_index) = plane%node(:,n_index) - weight * diff(:,j)
    end do
  end do
  
  deallocate(nID)
  deallocate(diff)
  
  
  
  !> ---------------------------------------
  !> ���b�V���f�[�^��paraview�ŏo��(debug�p)
  !> ---------------------------------------
  count = count + 1
  write(c,'(1I6.6)') count
  fname = 'plane_' // trim(c) // '.vtu'
  write(*,*) fname
  call output_paraview &
    (plane%dim,plane%nnode,plane%nbase_func,plane%nelem,plane%node,plane%elem,plane%mat_id,plane%mesh_type,fname)
  
  fname_pvtu = 'output/plane.pvtu'
  open(newunit=fio_pvtu,file=fname_pvtu,status='replace')
    write(fio_pvtu,'(a)') '<?xml version="1.0"?>'
    write(fio_pvtu,'(a)') '<VTKFile type="PUnstructuredGrid" version="1.0" byte_order="LittleEndian">'
    write(fio_pvtu,'(a)') '<PUnstructuredGrid GhostLevel="0">'
    write(fio_pvtu,'(a)') '<PPoints>'
    write(fio_pvtu,'(a)') '<PDataArray type="Float32" NumberOfComponents="3" Name="Points"/>'
    write(fio_pvtu,'(a)') '</PPoints>'
    write(fio_pvtu,'(a)') '<PCellData>'
    write(fio_pvtu,'(a)') '<PDataArray type="Int32" Name="mat_id" NumberOfComponents="1"/>'
    write(fio_pvtu,'(a)') '</PCellData>'
    do i=1, count
      write(c,'(1I6.6)') i
      fname = 'plane_' // trim(c) // '.vtu'
      write(fio_pvtu,'(a)') '<Piece Source="' // trim(fname) // '"/>'
    end do
    write(fio_pvtu,'(a)') '</PUnstructuredGrid>'
    write(fio_pvtu,'(a)') '</VTKFile>'
  close(fio_pvtu)
end subroutine correct_structural_lattices_with_edge