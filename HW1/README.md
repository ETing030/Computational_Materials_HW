# HW1: 請寫一個程式可以輸出一個 mass-spring system 的解

**更詳細的說明可見 `Damping.docx`**  
Code: `damping.f90`
以 fortran 資料作圖: `fortran_damping_data.xlsx`  
以 excel 資料作圖: `excel_damping_data.xlsx`  
excel 和 fortran 資料誤差作圖: `excel.vs.fortran.xlsx`  

---
**參見`Damping.docx`, `damping.f90`**
<div align=center><img src="https://latex.codecogs.com/svg.image?my''&plus;cy'&plus;ky=0" title="https://latex.codecogs.com/svg.image?my''+cy'+ky=0" /></div>

- 代入<div align=center><img src="https://latex.codecogs.com/svg.image?y=e^{\lambda&space;x}" title="https://latex.codecogs.com/svg.image?y=e^{\lambda x}" /></div> 和質量（m）、彈性係數（k）和阻尼係數（c），計算判斷式<div align=center><img src="https://latex.codecogs.com/svg.image?D=\sqrt{c^2-4mk}" title="https://latex.codecogs.com/svg.image?D=\sqrt{c^2-4mk}" /></div>
- 在不同初始條件下得到公式解<div align=center><img src="https://latex.codecogs.com/svg.image?\left\{\begin{matrix}\text{Case&space;I:}&y=C_1y_1&plus;C_2y_2&space;&&space;\text{if}&D>0\\\text{Case&space;II:}&y=C_1y_1&plus;tC_2y_2&&space;\text{if}&D=0\\\text{Case&space;III:}&y=e^{\frac{-c}{2m}t}\left&space;(&space;C_1\cos(\frac{\sqrt{-D}}{2m})&plus;C_2\sin(\frac{\sqrt{-D}}{2m})&space;\right&space;)&&space;\text{if}&D<0\end{matrix}\right." title="https://latex.codecogs.com/svg.image?\left\{\begin{matrix}\text{Case I:}&y=C_1y_1+C_2y_2 & \text{if}&D>0\\\text{Case II:}&y=C_1y_1+tC_2y_2& \text{if}&D=0\\\text{Case III:}&y=e^{\frac{-c}{2m}t}\left ( C_1\cos(\frac{\sqrt{-D}}{2m})+C_2\sin(\frac{\sqrt{-D}}{2m}) \right )& \text{if}&D<0\end{matrix}\right." /></div> 其中

<div align=center>

Case   | Damping
:---:  | :---: 
Case I   | Overdamping
Case II  | Critical damping
Case III | Underdamping
  
</div>

- 透過輸入的參數：質量（m）、彈性係數（k）和阻尼係數（c），再加上初始條件：初始座標（y(0)）和初始速度（ y'(0)），判斷在這些條件下為哪一個 Case，並以 0.1 秒作為區間，紀錄 y 軸座標，直至十秒

<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162912171-ed0cd549-04ca-47da-ae93-97688fefcc32.png' width='500'>
</div>

---
**參見`Damping.docx`, `fortran_damping_data.xlsx`, `excel_damping_data.xlsx`, `excel.vs.fortran.xlsx`**
- 以<div align=center><img src="https://latex.codecogs.com/svg.image?10y''&plus;cy'&plus;90=0&space;,\quad&space;y(0)=0.16,&space;y'(0)=0" title="https://latex.codecogs.com/svg.image?10y''+cy'+90=0 ,\quad y(0)=0.16, y'(0)=0" /></div>為例，分別代入 

<div align=center>

c(kg/sec)   | Case
:---:  | :---: 
100   | Overdamping
60    | Critical damping
10    | Underdamping
  
</div>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分別比較不同彈性係數和 Case 下 y軸隨時間的變化量，以作圖表示
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162916426-10af1524-d4bf-4e6e-9d8b-ff315d7cd360.png' width='500'>
</div>

- 將上述之結果與 excel 直接輸出解的函數值相比（在此用相減），其結果如下，誤差較大的為 Case III
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162917323-22c0807c-70cf-42a9-ac93-b3218cf29dbe.png' width='500'>
</div>
