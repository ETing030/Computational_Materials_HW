PROGRAM   amorphous3d_v2
          REAL::width,length,volume,radius,volume_atom,occupancy,rate_volume
          INTEGER::number_atoms,number_loops
          REAL::x,y,z
          INTEGER::i,clear,a,n,over
          REAL,PARAMETER::pi=3.14159265
          REAL,ALLOCATABLE::center(:,:)
          REAL::test(3)
          REAL::most_occupancy=0.74
          CHARACTER(1)::response
!---------------------------------------------------------------------------------------------------
          CALL random_seed

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the width(x-axis) of the area:"
          READ(*,*)width
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the length(y-axis) of the area:"
          READ(*,*)length
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the height(z-axis) of the area:"
          READ(*,*)height

          volume=width*length*height

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the radius of the circle:"
          READ(*,*)radius

          volume_atom=(4.0/3.0)*pi*radius**3
          rate_volume=volume/volume_atom
          !WRITE(*,*)rate_volume
          WRITE(*,*)"highest occupancy:","",most_occupancy
!------------------------------------------------------------------
          ALLOCATE(center(3,100000))                                       !原本想把allocate放在迴圈裡
          n=0                                                              !用ALLOCATE(center(3,n))
                                                                           !但ALLOCATE好像只能用一次
          number_loops=0                                                   !所以這樣寫
          number_atoms=1
          over=0

          DO
            n=n+1
            DO
              number_loops=number_loops+1
              clear=1
              CALL random_number(x)
              x=(width-2*radius)*x+radius                                        !!!
              CALL random_number(y)
              y=(length-2*radius)*y+radius
              CALL random_number(z)
              z=(height-2*radius)*z+radius
              test=(/x,y,z/)
              !WRITE(*,*)"test",test

              DO i=1,n
                IF(((center(1,i)-test(1))**2+(center(2,i)-test(2))**2+(center(3,i)-test(3))**2)<4*radius**2)THEN
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

            IF((width>=2*radius).AND.(length>=2*radius).AND.(height>=2*radius))THEN
              occupancy=(n*volume_atom)/volume
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
            IF(number_loops>=1000)EXIT
            IF(response=='N')EXIT
            IF(over==1)EXIT
          ENDDO

          DO i=1,n
            WRITE(*,*)center(1,i),"",center(2,i),"",center(3,i)
          ENDDO

          DEALLOCATE(center)

STOP
END PROGRAM

