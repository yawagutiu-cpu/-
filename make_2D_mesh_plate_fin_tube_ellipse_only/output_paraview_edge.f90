subroutine output_paraview_edge(edge1,edge2)
  use mod_parameters
  implicit none
  type(type_edge), intent(in) :: edge1(4), edge2(4)
  
  character(50) :: fname_list, fname, c1, c2, fname_pvtu
  integer :: fio_list, fio_pvtu
  integer :: i, j
  
  !call system('mkdir output')
  fname_list = 'output/output_list.dat'
  fname_pvtu = 'output/edge.pvtu'
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
  open(newunit=fio_list,file=fname_list,status='replace')
    write(c1,'(1I8.8)') 1
    do i=1, 4
      write(c2,'(1I8.8)') i
      fname = 'edge_' // trim(c1) // '_' // trim(c2) // '.vtu'
      write(fio_list,'(a)')  fname
      call output_2D_edge(edge1(i),fname)
      write(fio_pvtu,'(a)') '<Piece Source="' // trim(fname) // '"/>'
    end do
    write(c1,'(1I8.8)') 2
    do i=1, 4
      write(c2,'(1I8.8)') i
      fname = 'edge_' // trim(c1) // '_' // trim(c2) // '.vtu'
      write(fio_list,'(a)')  fname
      call output_2D_edge(edge2(i),fname)
      write(fio_pvtu,'(a)') '<Piece Source="' // trim(fname) // '"/>'
    end do
  close(fio_list)
    write(fio_pvtu,'(a)') '</PUnstructuredGrid>'
    write(fio_pvtu,'(a)') '</VTKFile>'
  close(fio_pvtu)
  
  write(*,*) ' Finish : output_2D_edge '
  
  contains
  
  subroutine output_2D_edge(edge,fname)
    use mod_parameters
    implicit none
    
    type(type_edge), intent(in) :: edge
    character(*), intent(in) :: fname
    
    integer, parameter :: dim=3
    integer :: nnode
    integer, parameter :: nbase_func = 2
    integer :: nelem
    double precision, allocatable :: node(:,:)
    integer, allocatable :: elem(:,:)
    integer, allocatable :: mat_id(:)
    
    integer :: i, j, k
    
    nnode = 0
    nelem = 0
    
    do i=1, 4
      nnode = nnode + edge%curve(i)%nnode
      nelem = nelem + edge%curve(i)%nnode - 1
    end do
    
    allocate(node(dim,nnode))
    allocate(elem(nbase_func,nelem))
    allocate(mat_id(nelem))
    node = 0.0d0
    elem = 0
    mat_id = 0
    
    nnode = 0
    nelem = 0
    do i=1, 4
      do j=1, edge%curve(i)%nnode
        nnode = nnode + 1
        node(:,nnode) = edge%curve(i)%node(:,j)
        if(j<edge%curve(i)%nnode) then
          nelem = nelem + 1
          elem(1,nelem) = nnode
          elem(2,nelem) = nnode + 1
          mat_id(nelem) = i
        end if
      end do
    end do
    
    !do i=1, nnode
    !  write(*,*) i
    !  write(*,*) node(:,i)
    !end do
    
    call output_paraview &
      (dim,nnode,nbase_func,nelem,node,elem,mat_id,3,fname)
    
  end subroutine
  
end subroutine