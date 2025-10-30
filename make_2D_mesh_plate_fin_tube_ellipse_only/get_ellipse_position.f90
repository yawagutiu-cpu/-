subroutine get_ellipse_position(x_R,y_R,Ra,Rb,t_s,t_e,n,node)
  implicit none
  double precision, intent(in) :: x_R,y_R,Ra,Rb,t_s,t_e
  integer, intent(in) :: n
  double precision, intent(inout) :: node(3,n+1)
  
  double precision :: t, dt
  double precision :: s,ds
  double precision :: total_length, delta_length
  double precision :: x_ellipse(2)
  double precision :: x1, y1
  integer :: n_sub
  integer :: count
  
  integer :: i
  
  !> initialize
  node(:,:) = 0.0d0
  
  n_sub = n * 1000  !> 分割数の倍率を上げるほど正確になる
  
  !> 最小角度
  dt = (t_e - t_s) / dble(n_sub)
  !> 曲線全体の長さを取得
  t = t_s
  s = 0.0d0
  do i=1, n_sub
    call get_length_ellipse(x_R,y_R,Ra,Rb,t,dt,ds,x_ellipse)
    s = s + ds
    t = t + dt
  end do
  total_length = s
  
  !> 曲線を等分するような座標値を取得
  delta_length = total_length / dble(n)
  !write(*,*) delta_length, total_length, n
  s = 0.0d0
  t = t_s
  count = 1
  do i=1, n_sub
    call get_length_ellipse(x_R,y_R,Ra,Rb,t,dt,ds,x_ellipse)
    s = s + ds
    t = t + dt
    if(s>=delta_length) then
      s = s - delta_length
      count = count + 1
      node(1:2,count) = x_ellipse(1:2)
    end if
  end do
  
  !> 始点と終点の座標はここで保存
  node(1,1) = x_R + Ra * cos(t_s)
  node(2,1) = y_R + Rb * sin(t_s)
  node(1,n+1) = x_R + Ra * cos(t_e)
  node(2,n+1) = y_R + Rb * sin(t_e)
  
  write(*,*) '*get_ellipse_curve'
  write(*,*) ' subdiv = ', n
  write(*,*) ' Ra, Rb = ', Ra, Rb
  write(*,*) node(:,1)
  write(*,*) node(:,n+1)
  write(*,*)
  
end subroutine