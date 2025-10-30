subroutine get_length_ellipse(x,y,a,b,t,dt,length,x_ellipse)
    implicit none
    double precision, intent(in) :: x,y,a,b,t,dt
    double precision, intent(out) :: length, x_ellipse(2)
    
    double precision :: xs(2),xe(2)
    
    xs(1) = x + a * cos(t)
    xs(2) = y + b * sin(t)
    xe(1) = x + a * cos(t+dt)
    xe(2) = y + b * sin(t+dt)
    
    length = sqrt(dot_product(xs-xe,xs-xe))
    x_ellipse(:) = xe(:)
end subroutine