PROGRAM   amorphous2d_v2
          REAL*8::width,length,area,radius,area_circle,occupancy,rate_area
          INTEGER::number_circles,number_loops
          REAL::x,y
          INTEGER::i,clear,a,n,over
          REAL,PARAMETER::pi=3.14159265
          REAL,ALLOCATABLE::center(:,:)
          REAL::test(2)

          REAL*8::most_width,most_length,remainder,most_occupancy
          INTEGER::number_width,number_length,most_circle,most_circle_triangle,most_circle_square

          CHARACTER(1)::response
!---------------------------------------------------------------------------------------------------
          CALL random_seed

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the width(x-axis) of the area:"
          READ(*,*)width
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the length(y-axis) of the area:"
          READ(*,*)length

          area=width*length

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the radius of the circle:"
          READ(*,*)radius

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
          ALLOCATE(center(2,100000))                                       !原本想把allocate放在迴圈裡
          n=0                                                              !用ALLOCATE(center(2,n))
                                                                           !但ALLOCATE好像只能用一次
          number_loops=0                                                   !所以這樣寫
          number_circles=1
          over=0

          DO
            n=n+1
            DO
              number_loops=number_loops+1
              clear=1
              CALL random_number(x)
              x=(width-2*radius)*x+radius                                        !!!
              CALL random_number(y)
              y=(length-2*radius)*y+radius                                       !!!
              test=(/x,y/)
              !WRITE(*,*)"test",test

              DO i=1,n
                IF(((center(1,i)-test(1))**2+(center(2,i)-test(2))**2)<4*radius**2)THEN
                  clear=0
                ENDIF
              ENDDO

              !WRITE(*,*)"clear",clear
              IF(clear==1 .OR. n==1)THEN
                center(:,n)=test
                WRITE(*,*)'number',n,center(:,n)
              ENDIF

              IF(clear==1 .OR. n==1)EXIT

              !WRITE(*,*)n
              IF(occupancy>=most_occupancy/2)EXIT
            ENDDO

            WRITE(*,*)"number of loops",number_loops

            IF(width>=2*radius.AND.length>=2*radius)THEN
              occupancy=(n*area_circle)/area
              WRITE(*,*)"Occupancy:"," ",occupancy
            ELSE
              WRITE(*,*)"uncomputable occupancy"
            ENDIF

            IF(occupancy>=(most_occupancy/2))THEN
              WRITE(*,*)"occupancy is over half of the highest occupancy!"
              over=1                                                           !
            ELSE
              WRITE(*,"(/A)",ADVANCE='NO')"add more atoms?(Y/N)"
              READ(*,*)response
            ENDIF
            IF(number_loops>=100)EXIT
            IF(response=='N')EXIT
            IF(over==1)EXIT
          ENDDO

          DO i=1,n
            WRITE(*,*)center(1,i)," ",center(2,i)
          ENDDO

          DEALLOCATE(center)

STOP
END PROGRAM

