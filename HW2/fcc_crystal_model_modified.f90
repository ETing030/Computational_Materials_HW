PROGRAM  fcc_crystal_model_modified
         !fcc��촹���I�y��: (0,0,0),(0.5,0.5,0),(0.5,0,0.5),(0,0.5,0.5)
         !x��V����N��,y��V����M��,z��V����L�� (N*M*L)
         !�����촹�Mx,y,z�b���׫ŧi
         !�@�|���I,�C���I�Ҽ{�T�Ӥ�V ���T���j��,�C�Ӱj�餺���ܶq(i,j,k)���ܥ|���I���@�Ӥ�V(x/y/z) (???

         REAL::x01,x02,x03,x04,y01,y02,y03,y04,z01,z02,z03,z04                                     !fcc��촹���I�y��
         REAL::x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4                                                 !�@�ϥΪ��y���I
         INTEGER::N,M,L
         REAL::unitx,unity,unitz
         INTEGER::i,j,k
         INTEGER::number                                                                           !���(�y��)�Ǹ�

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

         WRITE(*,*)"fcc crystal model maker"
         WRITE(*,*)"using (0,0,0),(0.5,0.5,0),(0.5,0,0.5),(0,0.5,0.5) as unit cell coordinates"    !�����I�y�Ъ��^������?
         WRITE(*,*)"please enter the number of replcation in x, y and z"
         READ(*,*)N,M,L
         WRITE(*,*)"please enter the lattice constant in x, y and z"
         READ(*,*)unitx,unity,unitz

         OPEN(UNIT=7,FILE="fcc.xyz",STATUS="unknown")

         number=4*N*M*L                                                                            !���`�@�X�����(�C�ӳ�촹�M�@�O���|���I)
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
                  WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'1',x1,y1,z1
                  !number=number+1
                  x2=x02+(i-1)*unitx
                  y2=y02+(j-1)*unity
                  z2=z02+(k-1)*unitz
                  WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'2',x2,y2,z2
                  !number=number+1
                  x3=x03+(i-1)*unitx
                  y3=y03+(j-1)*unity
                  z3=z03+(k-1)*unitz
                  WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'3',x3,y3,z3
                  !number=number+1
                  x4=x04+(i-1)*unitx
                  y4=y04+(j-1)*unity
                  z4=z04+(k-1)*unitz
                  WRITE(7,"(A,1x,F8.6,1x,F8.6,1x,F8.6)")'4',x4,y4,z4
               ENDDO
            ENDDO
         ENDDO

STOP
END PROGRAM