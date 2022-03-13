PROGRAM    test26     !neutrons move randomly in the shield wall
           REAL*8::wall_thickness
           INTEGER::limit,direction_changes,neutrons
           INTEGER::i,j
           INTEGER::number
           REAL*8::unit_move
           REAL*8::x,y
           CHARACTER(1)::response
           CALL RANDOM_SEED

           !WRITE(*,*)"please enter total # of neutrons"
           !READ(*,*)neutrons
           WRITE(*,*)"please enter the thickness of the shield wall"
           READ(*,*)wall_thickness
           WRITE(*,*)"please enter the unit move of the neutrons"
           READ(*,*)unit_move
           WRITE(*,*)"please enter the limit of direction changes"
           READ(*,*)limit

           DO
              direction_changes=limit
              x=0
              y=0

              DO
                CALL RANDOM_NUMBER(A)
                number=INT(4*A)

                IF(number==0) THEN
                   y=y+unit_move     !forward
                   WRITE(*,*)x,y
                   IF(y>=wall_thickness) EXIT
                ELSEIF(number==1) THEN
                   y=y-unit_move     !backward
                   WRITE(*,*)x,y
                   IF(y<0) EXIT
                ELSEIF(number==2) THEN
                   x=x+unit_move     !right
                   direction_changes=direction_changes-1
                   WRITE(*,*)x,y
                   !WRITE(*,*)direction_changes
                   IF(direction_changes<=0) EXIT
                ELSEIF(number==3) THEN
                   x=x-unit_move     !left
                   direction_changes=direction_changes-1
                   WRITE(*,*)x,y
                   !WRITE(*,*)direction_changes
                   IF(direction_changes<=0) EXIT
                ENDIF
              ENDDO

              IF(y>=wall_thickness) THEN
                 WRITE(*,*)"neutron excape"
              ELSEIF(y<0) THEN
                 WRITE(*,*)"neuton has back to in the reactor"
              ELSEIF(0==direction_changes) THEN
                 WRITE(*,*)"out of move,neutron dies"
              ENDIF
              
              WRITE(*,*)"another?(Y/N)"
              READ(*,*)response
              IF(response=='N')EXIT
           ENDDO

STOP
END PROGRAM