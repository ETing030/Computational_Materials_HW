PROGRAM  fcc_crystal_model_modified_4   ![111]cylinder
         !fcc單位晶格點座標: (0,0,0),(0.5,0.5,0),(0.5,0,0.5),(0,0.5,0.5)
         !x方向重複N次,y方向重複M次,z方向重複L次 (N*M*L)
         !關於單位晶胞x,y,z軸長度宣告
         !共四個點,每個點考慮三個方向 →三重迴圈,每個迴圈內的變量(i,j,k)改變四個點的一個方向(x/y/z) (???

         REAL::x01,x02,x03,x04,y01,y02,y03,y04,z01,z02,z03,z04                                     !fcc單位晶格點座標
         REAL::x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4                                                 !作圖用的座標點
         INTEGER::N,M,L
         REAL::unitx,unity,unitz                                                                   !單位晶格長度
         INTEGER::i,j,k
         INTEGER::number                                                                           !資料(座標)序號
         REAL::radius                                                                              !圓的半徑
         REAL::r_x0,r_y0,r_z0                                                                         !圓心座標
         REAL::r_x,r_y,r_z                                                                         !圓心(沿[111]移動後)
         REAL::distance                                                                            !圓心與任意點的距離
         REAL::length                                                                              !圓柱長度(因為L設過了所以用length)
         REAL::axischange
         REAL::unitlength                                                                          !圓心沿[111]移動的單位長度
         INTEGER::h                                                                                !　↑每移動一次移動多少幅度
         INTEGER::frequency                                                                        !取圓和圓之間的密度(頻率)
         REAL::error=0.0001
                                                                                                   !在固定長度的圓柱中
         x01=0                                                                                     !要取幾次(frequency)
         y01=0                                                                                     !基本上想讓這個數趨於無限大
         z01=0

         x02=0.5
         y02=0.5
         z02=0

         x03=0.5
         y03=0
         z03=0.5

         x04=0
         y04=0.5
         z04=0.5

         WRITE(*,*)"fcc crystal model maker--fcc cylinder!!!"
         WRITE(*,*)"using (0,0,0),(0.5,0.5,0),(0.5,0,0.5),(0,0.5,0.5) as unit cell coordinates"    !晶格點座標的英文怎麼講?
         WRITE(*,*)"please enter the number of replcation in x, y and z"
         READ(*,*)N,M,L
         WRITE(*,*)"please enter the lattice constant in x, y and z"                               !fcc晶格三軸等長
         READ(*,*)unitx,unity,unitz
         WRITE(*,*)"please enter the center of the circle (r_x0,r_y0,r_z0)"
         READ(*,*)r_x0,r_y0,r_z0
         WRITE(*,*)"please enter the radius of the circle"
         READ(*,*)radius
         WRITE(*,*)"please enter the length of the cylinder"
         READ(*,*)length

         frequency=100000
         axischange=length/SQRT(3.00)                                                              !最終圓心與最初圓心相距length
         unitlength=axischange/frequency                                                           !而距離公式推得最終與最初圓心,
                                                                                                   !其軸座標改變量為length/SQRT(3)
         OPEN(UNIT=7,FILE="fcccylinder.xyz",STATUS="unknown")

         number=4*N*M*L                                                                            !為總共幾筆資料(每個單位晶胞共記錄四個點)
         WRITE(7,*)number
         WRITE(7,*)
         number=0
         

         DO i=1,N
            DO j=1,M
               Do k=1,L
                  DO h=1,frequency+1
                     !number=number+1
                     x1=x01+(i-1)*unitx
                     y1=y01+(j-1)*unity                                                               !
                     z1=z01+(k-1)*unitz                                                               !
                     r_x=r_x0+(h-1)*1/REAL(frequency)*axischange
                     r_y=r_y0+(h-1)*1/REAL(frequency)*axischange
                     r_z=r_z0+(h-1)*1/REAL(frequency)*axischange
                     distance=SQRT((x1-r_x)**2+(y1-r_y)**2+(z1-r_z)**2)
                     IF(ABS((r_x+r_y+r_z)-(x1+y1+z1))<=error.AND.distance<=radius) THEN
                       WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'1',x1,y1,z1
                       number=number+1
                     ENDIF
                     !number=number+1
                     x2=x02+(i-1)*unitx
                     y2=y02+(j-1)*unity
                     z2=z02+(k-1)*unitz
                     distance=SQRT((x2-r_x)**2+(y2-r_y)**2+(z2-r_z)**2)
                     IF(ABS((r_x+r_y+r_z)-(x2+y2+z2))<=error.AND.distance<=radius) THEN
                       WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'2',x2,y2,z2
                       number=number+1
                     ENDIF
                     !number=number+1
                     x3=x03+(i-1)*unitx
                     y3=y03+(j-1)*unity
                     z3=z03+(k-1)*unitz
                     distance=SQRT((x3-r_x)**2+(y3-r_y)**2+(z3-r_z)**2)
                     IF(ABS((r_x+r_y+r_z)-(x3+y3+z3))<=error.AND.distance<=radius) THEN
                       WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'3',x3,y3,z3
                       number=number+1
                     ENDIF
                     !number=number+1
                     x4=x04+(i-1)*unitx
                     y4=y04+(j-1)*unity
                     z4=z04+(k-1)*unitz
                     distance=SQRT((x4-r_x)**2+(y4-r_y)**2+(z4-r_z)**2)
                     IF(ABS((r_x+r_y+r_z)-(x4+y4+z4))<=error.AND.distance<=radius) THEN
                       WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'4',x4,y4,z4
                       number=number+1
                     ENDIF
                  ENDDO
               ENDDO
            ENDDO
         ENDDO
         WRITE(*,*)number

STOP
END PROGRAM