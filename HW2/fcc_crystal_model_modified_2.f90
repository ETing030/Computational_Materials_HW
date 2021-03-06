PROGRAM  fcc_crystal_model_modified_2   !sphere
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
         REAL::radius                                                                              !球的半徑
         REAL::r_x,r_y,r_z                                                                         !球心(r_x,r_y,r_z)
         REAL::distance                                                                            !球心與任意點的距離

         x01=0
         y01=0
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

         WRITE(*,*)"fcc crystal model maker--fcc sphere!!!"
         WRITE(*,*)"using (0,0,0),(0.5,0.5,0),(0.5,0,0.5),(0,0.5,0.5) as unit cell coordinates"    !晶格點座標的英文怎麼講?
         WRITE(*,*)"please enter the number of replcation in x, y and z"
         READ(*,*)N,M,L
         WRITE(*,*)"please enter the lattice constant in x, y and z"                               !fcc晶格三軸等長
         READ(*,*)unitx,unity,unitz
         WRITE(*,*)"please enter the center of the circle (r_x,r_y,r_z)"
         READ(*,*)r_x,r_y,r_z
         WRITE(*,*)"please enter the radius of the circle"
         READ(*,*)radius

         OPEN(UNIT=7,FILE="fcccircle.xyz",STATUS="unknown")

         number=4*N*M*L                                                                            !為總共幾筆資料(每個單位晶胞共記錄四個點)
         WRITE(7,*)number
         WRITE(7,*)
         number=0

         DO i=1,N
            DO j=1,M
               Do k=1,L
                  !number=number+1
                  x1=x01+(i-1)*unitx
                  y1=y01+(j-1)*unity
                  z1=z01+(k-1)*unitz
                  distance=SQRT((x1-r_x)**2+(y1-r_y)**2+(z1-r_z)**2)
                  IF(distance<=radius) THEN
                    WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'1',x1,y1,z1
                  ENDIF
                  !number=number+1
                  x2=x02+(i-1)*unitx
                  y2=y02+(j-1)*unity
                  z2=z02+(k-1)*unitz
                  distance=SQRT((x2-r_x)**2+(y2-r_y)**2+(z2-r_z)**2)
                  IF(distance<=radius) THEN
                    WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'2',x2,y2,z2
                  ENDIF
                  !number=number+1
                  x3=x03+(i-1)*unitx
                  y3=y03+(j-1)*unity
                  z3=z03+(k-1)*unitz
                  distance=SQRT((x3-r_x)**2+(y3-r_y)**2+(z3-r_z)**2)
                  IF(distance<=radius) THEN
                    WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'3',x3,y3,z3
                  ENDIF
                  !number=number+1
                  x4=x04+(i-1)*unitx
                  y4=y04+(j-1)*unity
                  z4=z04+(k-1)*unitz
                  distance=SQRT((x4-r_x)**2+(y4-r_y)**2+(z4-r_z)**2)
                  IF(distance<=radius) THEN
                    WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'4',x4,y4,z4
                  ENDIF
               ENDDO
            ENDDO
         ENDDO

STOP
END PROGRAM