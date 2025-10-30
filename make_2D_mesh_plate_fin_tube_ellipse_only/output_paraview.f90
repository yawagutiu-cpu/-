
  
subroutine output_paraview &
    (dim,nnode,nbase_func,nelem,node,elem,mat_id,mesh_type,filename)
  implicit none
  
  integer, intent(in) :: dim, nnode
  integer, intent(in) :: nbase_func, nelem
  double precision, intent(in) :: node(dim,nnode)
  integer, intent(in) :: elem(nbase_func, nelem)
  integer, intent(in) :: mat_id(nelem)  !> 材料番号
  integer, intent(in) :: mesh_type  !> メッシュタイプ
  !> 六面体:12, 線:3, 四角:9
  character(*), intent(in) :: filename
  
  integer :: fio
  character(50) :: fname
  
  integer :: i, j
  
  !call system('mkdir output')
  
  fname = 'output/' // trim(filename)
  open(newunit=fio,file=fname,status='replace')
    write(fio,'(a)') '<?xml version="1.0"?>'
    write(fio,'(a)') '<VTKFile type="UnstructuredGrid" version="1.0">'
    write(fio,'(a)') '<UnstructuredGrid>'
    write(fio,'(a,1i0,a,1i0,a)') '<Piece NumberOfPoints="', nnode, '" NumberOfCells="', nelem, '">'
    
    write(fio,'(a)') '<Points>'
    write(fio,'(a)') '<DataArray type="Float32" NumberOfComponents="3" format="ascii">'
    do i=1, nnode
      write(fio,"(1p3e20.12)")(real(node(j,i)),j=1,dim)
    end do
    write(fio,"(a)")'</DataArray>'
    write(fio,"(a)")'</Points>'
    
    write(fio,"(a)")'<Cells>'
    write(fio,"(a)")'<DataArray type="Int32" Name="connectivity" format="ascii">'
    do i=1, nelem
      write(fio,"(8i8)")(elem(j,i)-1,j=1,nbase_func)
    enddo
    write(fio,"(a)")'</DataArray>'
    write(fio,"(a)")'<DataArray type="Int32" Name="offsets" format="ascii">'
    do i=1,nelem
      write(fio,"(x,i0,$)") nbase_func*i
    enddo
    write(fio,*)""
    write(fio,"(a)")'</DataArray>'
    write(fio,"(a)")'<DataArray type="UInt8" Name="types" format="ascii">'
    do i=1, nelem
      write(fio,"(i3,$)") mesh_type
    enddo
    write(fio,*) ''
    write(fio,"(a)")'</DataArray>'
    write(fio,"(a)")'</Cells>'
    
    write(fio,"(a)")'<CellData>'
    write(fio,"(a)")'<DataArray type="Int32" Name="mat_id" NumberOfComponents="1" format="ascii">'
    do i=1,nelem
      write(fio,"(i0)")mat_id(i)
    enddo
    write(fio,"(a)")'</DataArray>'
    write(fio,"(a)")'</CellData>'
    
    write(fio,"(a)")'</Piece>'
    write(fio,"(a)")'</UnstructuredGrid>'
    write(fio,"(a)")'</VTKFile>'
  close(fio)
  
  write(*,*) 'output : ', filename
  
end subroutine output_paraview