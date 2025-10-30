subroutine output_mesh_data(mesh,dir)
  use mod_parameters
  implicit none
  type(type_mesh), intent(in) :: mesh
  character(*), intent(in) :: dir
  
  character(50) :: fname
  integer :: fio
  integer :: i,j
  
  fname = trim(dir) // '/node.dat'
  open(newunit=fio,file=fname,status='replace')
    write(fio,'(2I10,1a)') mesh%nnode, mesh%dim, ' num nodes, dimension'
    do i=1, mesh%nnode
      write(fio,'(1I10,3E20.10)') i, (mesh%node(j,i),j=1,mesh%dim)
    end do
  close(fio)
  
  fname = trim(dir) // '/elem.dat'
  open(newunit=fio,file=fname,status='replace')
    write(fio,'(2I10,1a)') mesh%nelem, mesh%nbase_func, ' num elems, num nodes'
    do i=1, mesh%nelem
      write(fio,'(9I10)') i, (mesh%elem(j,i),j=1,mesh%nbase_func)
    end do
  close(fio)
  
  fname = trim(dir) // '/mat_id.dat'
  open(newunit=fio,file=fname,status='replace')
    write(fio,'(1I10,1a)') mesh%nelem, ' num elems'
    do i=1, mesh%nelem
      write(fio,'(2I10)') i, mesh%mat_id(i)
    end do
  close(fio)
  
end subroutine