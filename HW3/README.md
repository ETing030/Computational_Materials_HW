# HW3: 建立二維非晶材料模型（待補說明）
**repo Q2 和 Q3 說明估計很久以後才會補，`amorphous.docx` 為作業較詳細的說明**  
**程式檔為 `amorphous2d.f90`、`amorphous3d.f90`等相關檔案**
---
### Q1
**(1) n\*m 平方埃的面積裡，填入數個半徑為 r 埃的原子，測試填入數量由少到多，平均需要花多少的迴圈數才能做到**  
　 **參見`amorphous.docx`, `amorphous2d.f90`**

- 在程式中以 width、length 及 radius 分別代表題目所指的 n、m 及 r
- 隨機取原子圓心所在位置作為測試點，並判斷其與先前各原子圓心之間的距離有無小於原子直徑；小於者，捨棄測試點，並重新隨機抓取；大於或等於者，將測試點納入紀錄原子圓心的陣列中（center），並抓取下一個測試點。直至抓到所要求的原子數或達到所設條件限制（於下點說明），才停止抓取測試點
- 倘若給定面積已無空間，且面積內仍未達到所規定的原子數，可能會造成抓取測試點這個步驟無止盡地進行，形成 infinite loop。因此，**給定一變數 a，每當測試點和任一原子未滿足距離條件時，此變數便會加一**，若此值超過一定值（程式內設為1000000），則會跳出迴圈（備註：a 並非紀錄總迴圈數）
- 以下為測試結果  
欲在 10\*10 （平方埃）的面積中填入 20 個半徑為 1 （埃）的原子。而在此面積下，其最密排列可填入 25 個原子，亦即佔有率約 0.72。而 492876 為總迴圈數，其底下為各原子圓心之座標，若原子數不足規定額度，其圓心會以 (0, 0) 表示。最底下為在此結果下（塞入 15 個原子於此面積）之佔有率
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162939729-000de45b-145c-4439-9524-a6d3a6d20317.png' width='400'>
</div>

- 利用 GeoGebra 繪製此面積與 15 個原子以示意，圖中任兩原子圓心距離均大於原子直徑
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162938978-0f534a83-46c9-467c-ab25-c8cf0a5b17d1.png' width='300'>
</div>

- 在 10\*10 （平方埃）的面積中，填入 1~15 個半徑為 1 （埃）的原子，各進行五次，並取其迴圈數平均
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/163016324-d2e54a22-5e41-4b19-a61c-7af5255c55c0.png' width='800'>
</div>

- 題外話  
個人認為上一點不一定是最佳解，有可能測試點多次與空位錯開，造成未達原子數的情況下跳出迴圈時，面積內仍有放置原子的空間。此外，個人認為，在已確定有一原子與測試點不滿足距離條件時，a 加一後，就重新抓測試點，而非如程式中，須將測試點與**全部**原子計算條件後，才能另取測試點，程式的寫法會導致，在同一個測試點下，a 值可能不只加一。但不確定是因為 fortran 無法從子迴圈 EXIT 到母迴圈，還是事後才發現這點可以改進，才選擇用程式中的寫法

**(2) n\*m 平方埃的面積裡，填入數個半徑為 r 埃的原子，測試填入數量由少到多，預測在多少迴圈內才能達到最高理論佔有率的一半**  
　 **參見`amorphous.docx`, `amorphous2d_v2.f90`**

- 同樣採隨機取測試點，但改為每加入一個原子便訊問一次，是否還要加入更多原子，直至當前占有率高過理論上之最高佔有率之一半
- 關於最高佔有率：對應於程式中的三角排列與四角排列，其詳細說明過程參見`amorphous.docx`（但是有點亂）
- 下圖為測試結果，其中 number 後的數據為第幾個圓／原子與其圓心座標，當佔有率達標後，會顯示已放入之原子其圓心座標
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162939411-72a01db5-1ffa-4305-9818-3d393fad5fb6.png' width='400'>
</div>

<div align=center>
    由於圖片太長所以只擷取前後端
</div>

<div align=center>
 <img src='https://user-images.githubusercontent.com/39528069/163009481-83f4f4fb-5d1c-4ee9-aa8e-e9c9d2c4b9e8.png' width='400'>
</div>

- 以10\*10 （平方埃）的面積，半徑為 1 （埃）的原子，紀錄當佔有率過半時的迴圈數，進行十次並取其平均
<div align=center>
 <img src='https://user-images.githubusercontent.com/39528069/163019735-dfde0bd7-1051-4a24-9c21-9b837b6033de.png' height='300'>
</div>

---
### Q2
**將 Q1 的程式延伸到三維的非晶材料建模，並做相同的預測與驗證**  
　 **參見`amorphous.docx`, `amorphous3d.f90`**

**(1)**
- 以10\*10\*10 （立方埃）的體積，塞入 10 個半徑為 1 （埃）的原子
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162939971-13f8c213-a7fc-4a80-804e-531feaf0e3dd.png' width='400'>
</div>
- 將上例以 GeoGebra 呈現，各原子圓心間均大於其直徑
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162940089-8944eeb8-4ea4-4393-ab5a-32aec0a2d08e.png' width='300'>
</div>

**(2)**
---
<div align=center>
  <img src='https://user-images.githubusercontent.com/39528069/162940740-a6bb2fc1-3da8-48a4-97ad-403a5af89f5c.png' width='300'>
</div>

---

有甚麼方法可以有效的提升填充的成功率？請解釋你的想法，並將他以程式實現，且做驗證（比較第一題或第二題程式的迴圈數預測值，以及沒有違背填入準則） 

請改寫 test21.f90，將熱中子的路徑繪出（隨機選出十個熱中子的路徑繪出即可）
