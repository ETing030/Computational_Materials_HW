# Computational_Materials_HW
計算材料作業:D  
以下為各個作業之題目說明

- 題目為原封不動地從 moodle 搬過來 :)
- 建議用 light mode 閱讀  
- math to image: https://latex.codecogs.com/

## HW1
題目：請寫一個程式可以輸出一個 mass-spring system 的解
1. 請找出  <div align=center><img src="https://latex.codecogs.com/svg.image?my''&plus;cy'&plus;ky=0" title="https://latex.codecogs.com/svg.image?my''+cy'+ky=0" /></div>微分方程之解析解（寫出解的函數），給定<div align=center><img src="https://latex.codecogs.com/svg.image?y(0)=k_0,y'(0)=k_1" title="https://latex.codecogs.com/svg.image?y(0)=k_0,y'(0)=k_1" /></div> 根據<div align=center><img src="https://latex.codecogs.com/svg.image?\sqrt{c^2-4mk}" title="https://latex.codecogs.com/svg.image?\sqrt{c^2-4mk}" /></div>共有三種情形
2. 請將 1 所推導的結果，利用 FORTRAN 程式，給予m, c, k, k0, k1之值（自己設定），做判斷，然後輸出至少 10 點的 y(t) 值
3. 請將 2 所得的結果繪圖，並驗證三種情形下結果是正確（可用 excel 直接輸出解的函數值做驗證，三種情形皆需驗證）


## HW2
題目：建立 FCC 晶體模型
1. 請寫出 FCC 一個單位晶包內做平移對稱轉換後位置不重複的原子位置點座標及你設定的晶格常數
2. 利用這些座標點和晶格常數寫一個程式可以複製這些座標點位置，建立 FCC 的 N\*M\*L 的超晶包晶體模型
3. 請利用前述問題 2 的程式，改寫為製作 FCC 半徑為R的奈米球模型的程式
4. 請利用前述問題 2 的程式，改為製作軸向為 FCC 半徑為 R 長度為 L 的 [111] 方向的奈米柱


## HW3
題目：請寫一個程式可以建立二維非晶材料模型
1. 在一個 n\*m 平方埃的面積裡，填入數個半徑為 r 埃的原子。請你測試填入數量由少到多，平均需要花多少的迴圈數才能做到（請作圖，並預測在多少迴圈內才能達到最高理論佔有率的一半）。需驗證你的填入程式的確沒有違背準則（原子不可重疊也不可被邊緣切到。其中 n, m, r 由使用者給定）
2. 將第一題的程式延伸到三維的非晶材料建模，並做相同的預測與驗證
3. 有甚麼方法可以有效的提升填充的成功率？請解釋你的想法，並將他以程式實現，且做驗證（比較第一題或第二題程式的迴圈數預測值，以及沒有違背填入準則）
4. 請改寫 test21.f90，將熱中子的路徑繪出（隨機選出十個熱中子的路徑繪出即可）
