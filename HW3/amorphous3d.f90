PROGRAM   amorphous3d
          REAL::width,length,height,volume,radius,volume_atom,occupancy,rate_volume
          INTEGER::number_atoms,number_loops
          REAL::x,y,z
          INTEGER::i,clear,a,n    !n�������ثe�O�������M�ثe�ꪺ�ƶq
          REAL,PARAMETER::pi=3.14159265
          REAL,ALLOCATABLE::center(:,:)
          REAL::test(3)
          REAL::most_occupancy=0.74
!---------------------------------------------------------------------------------------------------
          CALL random_seed

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the width(x-axis) of the volume:"
          READ(*,*)width
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the length(y-axis) of the volume:"
          READ(*,*)length
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the height(z-axis) of the volume:"
          READ(*,*)height

          volume=width*length*height

          WRITE(*,"(/A)",ADVANCE='NO')"please enter the radius of the atoms:"
          READ(*,*)radius
          WRITE(*,"(/A)",ADVANCE='NO')"please enter the number of atoms:"
          READ(*,*)number_atoms

          volume_atom=(4.0/3.0)*pi*radius**3
          rate_volume=volume/volume_atom

          ALLOCATE(center(3,number_atoms))

          number_loops=0
          DO
            number_loops=number_loops+1
            CALL random_number(x)
            !WRITE(*,*)x
            x=(width-2*radius)*x+radius                                        !!!
            CALL random_number(y)
            !WRITE(*,*)y
            y=(length-2*radius)*y+radius                                       !!!
            CALL random_number(z)
            !WRITE(*,*)z
            z=(height-2*radius)*z+radius                                       !!!

            test=(/x,y,z/)
            !WRITE(*,*)test
            IF((width>=2*radius).AND.(length>=2*radius).AND.(height>=2*radius))THEN
              center(:,1)=test
              !WRITE(*,*)center
            ENDIF
            IF((width>=2*radius).AND.(length>=2*radius).AND.(height>=2*radius))EXIT
          ENDDO

          a=0
          n=1

          OPEN(unit=7,file="amorphous3d.d",status="UNKNOWN")
          WRITE(7,*)n,number_loops,center(1,n),"",center(2,n),"",center(3,n)

          DO
            number_loops=number_loops+1
            clear=1
            CALL random_number(x)
            x=(width-2*radius)*x+radius
            CALL random_number(y)
            y=(length-2*radius)*y+radius
            CALL random_number(z)
            z=(height-2*radius)*z+radius
            test=(/x,y,z/)

            DO i=1,number_atoms
              IF(((center(1,i)-test(1))**2+(center(2,i)-test(2))**2+(center(3,i)-test(3))**2)<4*radius**2)THEN
                clear=0
                IF(clear==0)EXIT
              ENDIF
            ENDDO


            IF(clear==1)THEN
              center(:,n+1)=test
              WRITE(7,*)n+1,number_loops,center(1,n+1),"",center(2,n+1),"",center(3,n+1)
              n=n+1
              a=a+1
            ENDIF


            IF(n==number_atoms)EXIT
            IF(number_atoms==1)EXIT
            !WRITE(*,*)n
            IF(a==1000000)EXIT                   !����@��loop�Ϊ�

          ENDDO

          !WRITE(*,*)a
          WRITE(*,*)number_loops


         ! DO i=1,number_atoms
         !   WRITE(*,*)center(1,i)," ",center(2,i)," ",center(3,i)
         ! ENDDO

          IF((width>=2*radius).AND.(length>=2*radius).AND.(height>=2*radius))THEN
            occupancy=(n*volume_atom)/volume
            WRITE(*,*)"Occupancy:"," ",occupancy
          ELSE
            WRITE(*,*)"uncomputable occupancy"
          ENDIF

          DEALLOCATE(center)

STOP
END PROGRAM

