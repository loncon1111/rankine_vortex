# Package rankine_vortex

# Đề bài: Mô phỏng cấu trúc động lực học của xoáy Rankine

## **1. Mục tiêu**
Xây dựng chương trình máy tính (sử dụng ngôn ngữ Fortran) để thiết lập lưới giá trị của trường áp suất và trường gió cho một xoáy thuận Rankine lý tưởng trong hệ tọa độ Descartes.
## **2. Các thông số thiết lập**
* **Kích thước lưới:** $N_x = 100, N_y = 100$.
* **Bước lưới:** $\Delta x = 1, \Delta y = 1$.
* **Tâm xoáy:** $(x_0, y_0) = (50.5, 50.5)$.
* **Bán kính lõi xoáy (Maximum Wind Radius):** $R_{max} = 10$.
* **Vận tốc tiếp tuyến cực đại:** $V_{max} = 20 \, (m/s)$.
* **Áp suất môi trường:** $P_{\infty} = 1000 \, (hPa)$.
* **Khối lượng riêng không khí:** $\rho = 1.2 \, (kg/m^3)$.
## **3. Các công thức toán học và vật lý**
### a. Tọa độ cực địa phương
Tại mỗi điểm $(i, j)$ trên lưới, xác định khoảng cách $r$ và góc $\theta$ so với tâm xoáy:
$$r = \sqrt{(i - x_0)^2 + (j - y_0)^2}$$
$$\theta = \arctan2(j - y_0, i - x_0)$$
### b. Trường vận tốc tiếp tuyến ($V_t$)
Vận tốc được xác định theo mô hình Rankine:
* **Vùng lõi** ($r \le R_{max}$): Xoáy vật rắn (Solid body rotation).
$$V_t(r) = V_{max} \frac{r}{R_{max}}$$
* **Vùng ngoài** ($r > R_{max}$): Xoáy phi ma sát (Irrotational flow).
$$V_t(r) = V_{max} \frac{R_{max}}{r}$$
### c. Chuyển đổi sang hệ tọa độ Descartes ($u, v$)
$$u = -V_t \sin(\theta)$$
$$v = V_t \cos(\theta)$$
### d. Trường áp suất ($P$)
Áp suất được tính toán dựa trên phương trình cân bằng lực ly tâm $\frac{1}{\rho} \frac{dP}{dr} = \frac{V_t^2}{r}$:
* **Vùng ngoài** ($r > R_{max}$):
$$P(r) = P_{\infty} - \frac{1}{2} \rho \left( V_{max} \frac{R_{max}}{r} \right)^2$$
* **Vùng trong** ($r \le R_{max}$):
$$P(r) = P(R_{max}) - \int_r^{R_{max}} \rho \frac{V_t^2}{r} dr = P_{\infty} - \rho V_{max}^2 \left( 1 - \frac{1}{2} \frac{r^2}{R_{max}^2} \right)$$

## Bổ sung tịnh tiến
* Thông số dịch chuyển:Vị trí tâm ban đầu: $(x_0, y_0) = (50.5, 50.5)$.
* Vận tốc tịnh tiến sang trái (hướng Tây): $U_c = -5.0$ m/s; $V_c = 0.0$ m/s.
* Thời gian khảo sát: $t = 10$ (đơn vị thời gian giả định).
* Bước thời gian: $\deltat = 0.01$
### Công thức tính toán
* Tọa độ tâm xoáy tại thời điểm $t$:
* 
$$x_t = x_0 + U_c \cdot t, \quad y_t = y_0 + V_c \cdot t$$

* Khoảng cách và góc cực:
  $r = \sqrt{(i-x_t)^2 + (j-y_t)^2}$;
  $\theta = \operatorname{atan2}(j-y_t, i-x_t)$.
* Trường gió tổng hợp:
$$u_{total} = u_{vortex} + U_c, \quad v_{total} = v_{vortex} + V_c$$

Trong đó $(u, v)_{vortex}$ được tính từ vận tốc tiếp tuyến $V_t(r)$ của mô hình Rankine.

## 4. Yêu cầu sản phẩm
* **Mã nguồn:** Viết bằng Fortran, xuất dữ liệu ra định dạng binary trực tiếp *(access='direct')*.
* **Tệp điều khiển (.ctl):** Để GrADS có thể đọc và hiển thị 3 biến: p (áp suất), u (gió đông-tây), v (gió nam-bắc).
* **Hình ảnh:** Vẽ bản đồ vector gió đè lên trường áp suất được tô màu (shaded).
