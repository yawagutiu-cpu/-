subroutine input
  use mod_parameters
  implicit none
  
  character(50) :: fname
  integer :: fio
  character(2) :: c
  character(50) :: cname
  
  write(*,*) '==============================='
  write(*,*) ' input_data -> input.dat'
  write(*,*) '-------------------------------'
  
  fname = './input/input.dat'
  open(newunit=fio,file=fname,status='old')
    read(fio,*) c
    read(fio,*) flag_debug_input
    read(fio,*) 
    read(fio,*) c
    read(fio,*) Lx
    read(fio,*) Ly
    read(fio,*) nx
    read(fio,*) ny
    read(fio,*) nfin
    read(fio,*) x_R
    read(fio,*) y_R
    read(fio,*) Ra
    read(fio,*) Rb
    read(fio,*) Rt
    read(fio,*) nR
    read(fio,*) 
    read(fio,*) c
    read(fio,*) t_fin_m
    read(fio,*) t_fin_p
    read(fio,*) t_tube_m
    read(fio,*) t_tube_p
    read(fio,*) t_mesh
  close(fio)
  
  if(flag_debug_input) call debug_input
  
end subroutine
  
subroutine debug_input
  use mod_parameters
  implicit none
  
  integer :: i, j, k
  
  write(*,*) '-------------------------------'
  write(*,*) ' debug_input'
  write(*,*) '-------------------------------'
  
  write(*,*) 'Lx', Lx
  write(*,*) 'Ly', Ly
  write(*,*) 'nx', nx
  write(*,*) 'ny', ny
  write(*,*) 'nfin', nfin
  write(*,*) 'x_R', x_R
  write(*,*) 'y_R', y_R
  write(*,*) 'Ra', Ra
  write(*,*) 'Rt', Rt
  write(*,*) 'nR', nR
  write(*,*) 't_fin_m', t_fin_m
  write(*,*) 't_fin_p', t_fin_p
  write(*,*) 't_tube_m', t_tube_m
  write(*,*) 't_tube_p', t_tube_p
  write(*,*) 't_mesh', t_mesh
  write(*,*) '-------------------------------'
  write(*,*)
    
end subroutine  