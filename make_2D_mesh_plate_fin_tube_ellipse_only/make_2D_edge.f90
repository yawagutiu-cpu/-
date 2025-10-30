subroutine make_2D_edge(tube,fin)
  use mod_parameters
  implicit none
  
  type(type_edge),intent(inout) :: tube(4), fin(4)
  
  double precision :: x_start(3), x_end(3)  !> 直線の始点と終点
  double precision :: t_start, t_end  !> 角度の始点と終点
  double precision :: x_in(3,5), x_out(3,5)  !> 角4点の座標を保存(1=5)
  double precision :: t_p(5)  !> 角4点の角度を保存(1=5)
  double precision :: Rat, Rbt
  double precision :: x1(3), x2(3), x3(3), x4(3)
  
  integer :: i, j, k
  
  !> 肉厚込みの楕円径
  Rat = Ra + Rt
  Rbt = Rb + Rt
  
  !> ----------------------------
  !> フィン上側領域の節点数の指定
  !> ----------------------------
  !> フィン上辺の節点
  fin(1)%curve(1)%nnode = nx + 1
  !> フィン円弧の節点
  fin(1)%curve(2)%nnode = nx + 1
  !> フィン斜辺左
  fin(1)%curve(3)%nnode = nfin + 1
  !> フィン斜辺右
  fin(1)%curve(4)%nnode = nfin + 1
  
  !> フィン左側領域
  fin(3)%curve(1)%nnode = ny + 1
  fin(3)%curve(2)%nnode = ny + 1
  fin(3)%curve(3)%nnode = nfin + 1
  fin(3)%curve(4)%nnode = nfin + 1
  !> フィン下側領域
  do i=1, 4
    fin(2)%curve(i)%nnode = fin(1)%curve(i)%nnode
  end do
  !> フィン右側領域
  do i=1, 4
    fin(4)%curve(i)%nnode = fin(3)%curve(i)%nnode
  end do
  
  !> ----------------------------
  !> tube領域の節点数の指定
  !> ----------------------------
  tube(1)%curve(1)%nnode = nx + 1
  tube(1)%curve(2)%nnode = nx + 1
  tube(1)%curve(3)%nnode = nR + 1
  tube(1)%curve(4)%nnode = nR + 1
  do i=1, 4
    tube(2)%curve(i)%nnode = tube(1)%curve(i)%nnode
  end do
  tube(3)%curve(1)%nnode = ny + 1
  tube(3)%curve(2)%nnode = ny + 1
  tube(3)%curve(3)%nnode = nR + 1
  tube(3)%curve(4)%nnode = nR + 1
  do i=1, 4
    tube(4)%curve(i)%nnode = tube(3)%curve(i)%nnode
  end do
  
  !> ----------------------------
  !> 次元の指定とallocate
  !> ----------------------------
  !> 3次元
  do i=1, 4
    do j=1, 4
      fin(i)%curve(j)%dim = 3
      tube(i)%curve(j)%dim = 3
    end do
  end do
  !> 節点データをallocate
  do i=1, 4
    do j=1, 4
      allocate(fin(i)%curve(j)%node(fin(i)%curve(j)%dim,fin(i)%curve(j)%nnode))
      allocate(tube(i)%curve(j)%node(tube(i)%curve(j)%dim,tube(i)%curve(j)%nnode))
      fin(i)%curve(j)%node(:,:) = 0.0d0
      tube(i)%curve(j)%node(:,:) = 0.0d0
    end do
  end do
  
  !> ----------------------------
  !> 節点座標を格納
  !> ----------------------------
  !> フィン上側領域
  !> フィン上辺の節点座標(1-2)
  !> 始点と終点を指定(直線)
  x_start(:) = 0.0d0
  x_end(:) = 0.0d0
  x_start(1) = Lx / 2.0d0
  x_start(2) = Ly / 2.0d0
  x_end(1) = -Lx / 2.0d0
  x_end(2) =  Ly / 2.0d0
  !> 直線状の各節点を格納
  call get_line_position(x_start,x_end,nx,fin(1)%curve(1)%node)
  
  !> フィンの楕円上側の節点座標を指定(4-3)
  t_start = pi / 4.0d0
  t_end = 3.0d0 * pi / 4.0d0
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,nx,fin(1)%curve(2)%node)
  
  !> フィンの斜線右側を確保(1-4)
  x_start(1) = Lx / 2.0d0
  x_start(2) = Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_start)
  x_end(2) =  y_R + Rbt * sin(t_start)
  call get_line_position(x_start,x_end,nfin,fin(1)%curve(3)%node)
  
  !> フィンの斜線左側を確保(2-3)
  x_start(1) = -Lx / 2.0d0
  x_start(2) =  Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_end)
  x_end(2) =  y_R + Rbt * sin(t_end)
  call get_line_position(x_start,x_end,nfin,fin(1)%curve(4)%node)
  
  !> ----------------------------
  !> フィン下側領域
  !> ----------------------------
  !> 対称フィンでは上側領域を180度回転コピーに相当
  !> 1-2
  x_start(1) = -Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  Lx / 2.0d0
  x_end(2) = -Ly / 2.0d0
  call get_line_position(x_start,x_end,nx,fin(2)%curve(1)%node)
  
  !> フィンの楕円上側の節点座標を指定(4-3)
  t_start = 5.0d0 * pi / 4.0d0
  t_end = 7.0d0 * pi / 4.0d0
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,nx,fin(2)%curve(2)%node)
  
  !> フィンの斜線左下を確保(1-4)
  x_start(1) = -Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_start)
  x_end(2) =  y_R + Rbt * sin(t_start)
  call get_line_position(x_start,x_end,nfin,fin(2)%curve(3)%node)
  
  !> フィンの斜線右下を確保(2-3)
  x_start(1) =  Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_end)
  x_end(2) =  y_R + Rbt * sin(t_end)
  call get_line_position(x_start,x_end,nfin,fin(2)%curve(4)%node)
  
  !> ----------------------------
  !> フィン左側領域
  !> ----------------------------
  !> 1-2
  x_start(1) = -Lx / 2.0d0
  x_start(2) = +Ly / 2.0d0
  x_end(1) = -Lx / 2.0d0
  x_end(2) = -Ly / 2.0d0
  call get_line_position(x_start,x_end,ny,fin(3)%curve(1)%node)
  
  !> フィンの楕円の節点座標を指定(4-3)
  t_start = 3.0d0 * pi / 4.0d0
  t_end = 5.0d0 * pi / 4.0d0
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,ny,fin(3)%curve(2)%node)
  
  !> (1-4)
  x_start(1) = -Lx / 2.0d0
  x_start(2) = +Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_start)
  x_end(2) =  y_R + Rbt * sin(t_start)
  call get_line_position(x_start,x_end,nfin,fin(3)%curve(3)%node)
  
  !> (2-3)
  x_start(1) = -Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_end)
  x_end(2) =  y_R + Rbt * sin(t_end)
  call get_line_position(x_start,x_end,nfin,fin(3)%curve(4)%node)
  
  !> ----------------------------
  !> フィン右側領域
  !> ----------------------------
  !> 1-2
  x_start(1) = +Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  Lx / 2.0d0
  x_end(2) =  Ly / 2.0d0
  call get_line_position(x_start,x_end,ny,fin(4)%curve(1)%node)
  
  !> フィンの楕円の節点座標を指定(4-3)
  t_start = 7.0d0 * pi / 4.0d0
  t_end = 9.0d0 * pi / 4.0d0
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,ny,fin(4)%curve(2)%node)
  
  !> (1-4)
  x_start(1) = +Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_start)
  x_end(2) =  y_R + Rbt * sin(t_start)
  call get_line_position(x_start,x_end,nfin,fin(4)%curve(3)%node)
  
  !> (2-3)
  x_start(1) =  Lx / 2.0d0
  x_start(2) =  Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_end)
  x_end(2) =  y_R + Rbt * sin(t_end)
  call get_line_position(x_start,x_end,nfin,fin(4)%curve(4)%node)
  
  !> ----------------------------
  !> tube領域の節点座標を取得
  !> ----------------------------
  x_in(:,:) = 0.0d0
  x_out(:,:) = 0.0d0
  t_p(:) = 0.0d0
  t_p(1) = 1.0d0 * pi / 4.0d0
  t_p(2) = 3.0d0 * pi / 4.0d0
  t_p(3) = 5.0d0 * pi / 4.0d0
  t_p(4) = 7.0d0 * pi / 4.0d0
  t_p(5) = 9.0d0 * pi / 4.0d0
  do i=1, 5
    x_in(1,i) = x_R + Ra * cos(t_p(i))
    x_in(2,i) = y_R + Rb * sin(t_p(i))
    x_out(1,i) = x_R + Rat * cos(t_p(i))
    x_out(2,i) = y_R + Rbt * sin(t_p(i))
  end do
  !> tube上側
  x1(:) = x_out(:,1)
  x2(:) = x_out(:,2)
  x3(:) = x_in(:,2)
  x4(:) = x_in(:,1)
  t_start = t_p(1)
  t_end = t_p(2)
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,nx,tube(1)%curve(1)%node)
  call get_ellipse_position(x_R,y_R,Ra ,Rb ,t_start,t_end,nx,tube(1)%curve(2)%node)
  call get_line_position(x1(:),x4(:),nR,tube(1)%curve(3)%node)
  call get_line_position(x2(:),x3(:),nR,tube(1)%curve(4)%node)
  !> tube下側
  x1(:) = x_out(:,3)
  x2(:) = x_out(:,4)
  x3(:) = x_in(:,4)
  x4(:) = x_in(:,3)
  t_start = t_p(3)
  t_end = t_p(4)
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,nx,tube(2)%curve(1)%node)
  call get_ellipse_position(x_R,y_R,Ra ,Rb ,t_start,t_end,nx,tube(2)%curve(2)%node)
  call get_line_position(x1(:),x4(:),nR,tube(2)%curve(3)%node)
  call get_line_position(x2(:),x3(:),nR,tube(2)%curve(4)%node)
  !> tube左側
  x1(:) = x_out(:,2)
  x2(:) = x_out(:,3)
  x3(:) = x_in(:,3)
  x4(:) = x_in(:,2)
  t_start = t_p(2)
  t_end = t_p(3)
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,ny,tube(3)%curve(1)%node)
  call get_ellipse_position(x_R,y_R,Ra ,Rb ,t_start,t_end,ny,tube(3)%curve(2)%node)
  call get_line_position(x1(:),x4(:),nR,tube(3)%curve(3)%node)
  call get_line_position(x2(:),x3(:),nR,tube(3)%curve(4)%node)
  !> tube右側
  x1(:) = x_out(:,4)
  x2(:) = x_out(:,5)
  x3(:) = x_in(:,5)
  x4(:) = x_in(:,4)
  t_start = t_p(4)
  t_end = t_p(5)
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,ny,tube(4)%curve(1)%node)
  call get_ellipse_position(x_R,y_R,Ra ,Rb ,t_start,t_end,ny,tube(4)%curve(2)%node)
  call get_line_position(x1(:),x4(:),nR,tube(4)%curve(3)%node)
  call get_line_position(x2(:),x3(:),nR,tube(4)%curve(4)%node)
end subroutine