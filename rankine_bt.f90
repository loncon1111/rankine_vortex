PROGRAM rankine
   !!! De bai: Tao truong xoay Rankine
   implicit none

   ! Khai bao
   integer, parameter :: nx = 100, ny = 100 ! Kich thuoc luoi
   real, parameter    :: dx = 1, dy = 1     ! Buoc luoi
   real, parameter    :: x0 = 50.5, y0 = 50.5 ! Tam xoay
   real, parameter    :: rmax = 10          ! Ban kinh loi xoay
   real, parameter    :: vmax = 20          ! Van toc tiep tuyen cuc dai
   real, parameter    :: p0 = 1000          ! ap suat moi truong
   real, parameter    :: rho = 1.2          ! Khoi luong rieng khong khi

   integer :: i,j
   real    :: r, theta ! (Buoc 3.a)
   real    :: Vt       ! Van toc tiep tuyen (Buoc 3.b)
   real, dimension(nx,ny) :: u, v ! Van toc tren htd Descartes (Buoc 3.c)
   real, dimension(nx,ny) :: p    ! Truong ap suat (Buoc 3.d)

   ! Cac cau lenh thuc hien
   do i = 1, nx
   do j = 1, ny
      ! Buoc 3.a
      r     = sqrt( (real(i) - x0)**2 + (real(i) - y0)**2 ) 
      theta = atan2( real(j) - y0, real(j) - x0 )
      ! Buoc 3.b
      if ( r .le. rmax) then
         Vt = vmax * r / rmax
      else
         Vt = vmax * rmax / r
      end if
      ! Buoc 3.c
      u(i,j) = -Vt * sin(theta)
      v(i,j) =  Vt * cos(theta)
      ! Buoc 3.d
      if ( r .gt. rmax) then
         p(i,j) = p0 - 0.5 * rho * (vmax * rmax/r)**2
      else
         p(i,j) = p0 - rho * vmax**2 * (1 - 0.5 * (r / rmax)**2)
      end if
   end do
   end do

   open(1000, file='xoay_rankine.dat', form='unformatted',access='direct',recl=4*nx*ny)
       write(1000, rec=1) ((u(i,j),i=1,nx),j=1,ny) 
       write(1000, rec=2) ((v(i,j),i=1,nx),j=1,ny)
       write(1000, rec=3) ((p(i,j),i=1,nx),j=1,ny)
   close(1000)

   print*, "Hoan thanh! Du lieu da duoc ghi vao file xoay_rankine.dat"
END PROGRAM 
