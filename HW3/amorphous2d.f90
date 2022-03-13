PROGRAM   amorphous2d
          REAL*8::width,length,area,radius,area_circle,occupancy,rate_area
          INTEGER::number_circles,number_loops
          REAL::x,y
          INTEGER::i,clear,a,n    !n為紀錄目前記錄的欄位和目前圓的數量 !clear當布林值用
          REAL,PARAMETER::pi=3.14159265
          REAL,ALLOCATABLE::center(:,:)
          REAL::test(2)

          REAL*8::most_width,most_length,remainder,most_occupancy
          INTEGER::number_width,number_length,most_circle,most_circle_triangle,most_circle_square
!---------------------------------------------------------------------------------------------------
          CALL random_seed

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the width(x-axis) of the area:"
          READ(*,*)width
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the length(y-axis) of the area:"
          READ(*,*)length

          area=width*length

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the radius of the circle:"
          READ(*,*)radius
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the number of circles:"
          READ(*,*)number_circles
          ALLOCATE(center(2,number_circles))

          area_circle=pi*radius**2
          rate_area=area/area_circle
          !WRITE(*,*)rate_area
!------------------------三角排列----------------------------------
          most_length=(length/radius-2.0)/SQRT(3.0)
          number_length=INT(most_length)+1
          !WRITE(*,*)number_length
          IF(width>=3*radius)THEN
            most_width=(width-3*radius)/(2.0*radius)
            number_width=INT(most_width)+1
            remainder=DMOD((width-3*radius),(2.0*radius))
            !WRITE(*,*)"remainder",remainder
          ELSE
            number_width=(number_length+1)/2
          ENDIF
          most_circles_triangle=number_length*number_width
          IF(remainder>=radius)THEN
            most_circles_triangle=most_circles_triangle+(number_length+1)/2
          ENDIF
          !WRITE(*,*)most_circles_triangle
!------------------------四角排列----------------------------------
          most_length=length/(radius*2.0)
          number_length=INT(most_length)
          most_width=width/(radius*2.0)
          number_width=INT(most_width)
          most_circles_square=number_length*number_width
          !WRITE(*,*)most_circles_square
!------------------------------------------------------------------
          IF(most_circles_triangle>=most_circles_square)THEN               !取較密者
            most_circles=most_circles_triangle
          ELSE
            most_circles=most_circles_square
          ENDIF
          WRITE(*,*)"most number of circle:"," ",most_circles
          most_occupancy=most_circles*area_circle/area
          WRITE(*,*)"highest occupancy:"," ",most_occupancy
!------------------------------------------------------------------
          
          number_loops=0
          DO
            number_loops=number_loops+1
            CALL random_number(x)
            !WRITE(*,*)x
            x=(width-2*radius)*x+radius                                        !!!
            CALL random_number(y)
            !WRITE(*,*)y
            y=(length-2*radius)*y+radius                                       !!!
            !WRITE(*,*)x,y
            test=(/x,y/)
            !WRITE(*,*)test
            IF(width>=2*radius.AND.length>=2*radius)THEN
              center(:,1)=test
              !WRITE(*,*)center
            ENDIF
            IF(width>=2*radius.AND.length>=2*radius)EXIT
          ENDDO

          a=0
          n=1

          OPEN(unit=7,file="amorphous2d.d",status="UNKNOWN")
          !WRITE(*,*)n,number_loops,center(1,n),"",center(2,n)
          WRITE(7,*)n,number_loops,center(1,n),"",center(2,n)

          DO
            number_loops=number_loops+1
            clear=1
            CALL random_number(x)
            x=(width-2*radius)*x+radius                                        !!!
            CALL random_number(y)
            y=(length-2*radius)*y+radius                                       !!!
            test=(/x,y/)

            DO i=1,number_circles
              IF(((center(1,i)-test(1))**2+(center(2,i)-test(2))**2)<4*radius**2)THEN
                clear=0
              ENDIF
            ENDDO

            IF(clear==1)THEN
              center(:,n+1)=test
              !WRITE(*,*)'number',n+1,center(:,n+1)
              WRITE(7,*)n+1,number_loops,center(1,n+1),"",center(2,n+1)
              n=n+1
              a=a+1
            ENDIF

            IF(n==number_circles)EXIT
            IF(number_circles==1)EXIT
            !WRITE(*,*)n
            IF(a==1000000)EXIT                   !防止一直loop用的
          ENDDO

          !WRITE(*,*)a
          WRITE(*,*)number_loops

          !DO i=1,number_circles
          !  WRITE(*,*)center(1,i)," ",center(2,i)
          !ENDDO

          IF(width>=2*radius.AND.length>=2*radius)THEN
            occupancy=(n*area_circle)/area
            WRITE(*,*)"Occupancy:"," ",occupancy
          ELSE
            WRITE(*,*)"uncomputable occupancy"
          ENDIF

          DEALLOCATE(center)
STOP
END PROGRAM

