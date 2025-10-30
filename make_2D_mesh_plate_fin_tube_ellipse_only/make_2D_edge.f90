subroutine make_2D_edge(tube,fin)
  use mod_parameters
  implicit none
  
  type(type_edge),intent(inout) :: tube(4), fin(4)
  
  double precision :: x_start(3), x_end(3)  !> �����̎n�_�ƏI�_
  double precision :: t_start, t_end  !> �p�x�̎n�_�ƏI�_
  double precision :: x_in(3,5), x_out(3,5)  !> �p4�_�̍��W��ۑ�(1=5)
  double precision :: t_p(5)  !> �p4�_�̊p�x��ۑ�(1=5)
  double precision :: Rat, Rbt
  double precision :: x1(3), x2(3), x3(3), x4(3)
  
  integer :: i, j, k
  
  !> �������݂̑ȉ~�a
  Rat = Ra + Rt
  Rbt = Rb + Rt
  
  !> ----------------------------
  !> �t�B���㑤�̈�̐ߓ_���̎w��
  !> ----------------------------
  !> �t�B����ӂ̐ߓ_
  fin(1)%curve(1)%nnode = nx + 1
  !> �t�B���~�ʂ̐ߓ_
  fin(1)%curve(2)%nnode = nx + 1
  !> �t�B���ΕӍ�
  fin(1)%curve(3)%nnode = nfin + 1
  !> �t�B���ΕӉE
  fin(1)%curve(4)%nnode = nfin + 1
  
  !> �t�B�������̈�
  fin(3)%curve(1)%nnode = ny + 1
  fin(3)%curve(2)%nnode = ny + 1
  fin(3)%curve(3)%nnode = nfin + 1
  fin(3)%curve(4)%nnode = nfin + 1
  !> �t�B�������̈�
  do i=1, 4
    fin(2)%curve(i)%nnode = fin(1)%curve(i)%nnode
  end do
  !> �t�B���E���̈�
  do i=1, 4
    fin(4)%curve(i)%nnode = fin(3)%curve(i)%nnode
  end do
  
  !> ----------------------------
  !> tube�̈�̐ߓ_���̎w��
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
  !> �����̎w���allocate
  !> ----------------------------
  !> 3����
  do i=1, 4
    do j=1, 4
      fin(i)%curve(j)%dim = 3
      tube(i)%curve(j)%dim = 3
    end do
  end do
  !> �ߓ_�f�[�^��allocate
  do i=1, 4
    do j=1, 4
      allocate(fin(i)%curve(j)%node(fin(i)%curve(j)%dim,fin(i)%curve(j)%nnode))
      allocate(tube(i)%curve(j)%node(tube(i)%curve(j)%dim,tube(i)%curve(j)%nnode))
      fin(i)%curve(j)%node(:,:) = 0.0d0
      tube(i)%curve(j)%node(:,:) = 0.0d0
    end do
  end do
  
  !> ----------------------------
  !> �ߓ_���W���i�[
  !> ----------------------------
  !> �t�B���㑤�̈�
  !> �t�B����ӂ̐ߓ_���W(1-2)
  !> �n�_�ƏI�_���w��(����)
  x_start(:) = 0.0d0
  x_end(:) = 0.0d0
  x_start(1) = Lx / 2.0d0
  x_start(2) = Ly / 2.0d0
  x_end(1) = -Lx / 2.0d0
  x_end(2) =  Ly / 2.0d0
  !> ������̊e�ߓ_���i�[
  call get_line_position(x_start,x_end,nx,fin(1)%curve(1)%node)
  
  !> �t�B���̑ȉ~�㑤�̐ߓ_���W���w��(4-3)
  t_start = pi / 4.0d0
  t_end = 3.0d0 * pi / 4.0d0
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,nx,fin(1)%curve(2)%node)
  
  !> �t�B���̎ΐ��E�����m��(1-4)
  x_start(1) = Lx / 2.0d0
  x_start(2) = Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_start)
  x_end(2) =  y_R + Rbt * sin(t_start)
  call get_line_position(x_start,x_end,nfin,fin(1)%curve(3)%node)
  
  !> �t�B���̎ΐ��������m��(2-3)
  x_start(1) = -Lx / 2.0d0
  x_start(2) =  Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_end)
  x_end(2) =  y_R + Rbt * sin(t_end)
  call get_line_position(x_start,x_end,nfin,fin(1)%curve(4)%node)
  
  !> ----------------------------
  !> �t�B�������̈�
  !> ----------------------------
  !> �Ώ̃t�B���ł͏㑤�̈��180�x��]�R�s�[�ɑ���
  !> 1-2
  x_start(1) = -Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  Lx / 2.0d0
  x_end(2) = -Ly / 2.0d0
  call get_line_position(x_start,x_end,nx,fin(2)%curve(1)%node)
  
  !> �t�B���̑ȉ~�㑤�̐ߓ_���W���w��(4-3)
  t_start = 5.0d0 * pi / 4.0d0
  t_end = 7.0d0 * pi / 4.0d0
  call get_ellipse_position(x_R,y_R,Rat,Rbt,t_start,t_end,nx,fin(2)%curve(2)%node)
  
  !> �t�B���̎ΐ��������m��(1-4)
  x_start(1) = -Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_start)
  x_end(2) =  y_R + Rbt * sin(t_start)
  call get_line_position(x_start,x_end,nfin,fin(2)%curve(3)%node)
  
  !> �t�B���̎ΐ��E�����m��(2-3)
  x_start(1) =  Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  x_R + Rat * cos(t_end)
  x_end(2) =  y_R + Rbt * sin(t_end)
  call get_line_position(x_start,x_end,nfin,fin(2)%curve(4)%node)
  
  !> ----------------------------
  !> �t�B�������̈�
  !> ----------------------------
  !> 1-2
  x_start(1) = -Lx / 2.0d0
  x_start(2) = +Ly / 2.0d0
  x_end(1) = -Lx / 2.0d0
  x_end(2) = -Ly / 2.0d0
  call get_line_position(x_start,x_end,ny,fin(3)%curve(1)%node)
  
  !> �t�B���̑ȉ~�̐ߓ_���W���w��(4-3)
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
  !> �t�B���E���̈�
  !> ----------------------------
  !> 1-2
  x_start(1) = +Lx / 2.0d0
  x_start(2) = -Ly / 2.0d0
  x_end(1) =  Lx / 2.0d0
  x_end(2) =  Ly / 2.0d0
  call get_line_position(x_start,x_end,ny,fin(4)%curve(1)%node)
  
  !> �t�B���̑ȉ~�̐ߓ_���W���w��(4-3)
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
  !> tube�̈�̐ߓ_���W���擾
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
  !> tube�㑤
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
  !> tube����
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
  !> tube����
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
  !> tube�E��
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