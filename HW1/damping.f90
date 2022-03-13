PROGRAM damping

        implicit none                           !�٤��ӲM���o��n�F�����L���ӥi�H���Ϊ��ˤl
                                                !D=discriminant�P�O��
                                                !�f_1�Ÿ����ӻ{�]����root���
	REAL*8::m,c,k,k0,k1,root1,root2,t,D
	REAL*8::C1,C2                           !��y(t)���Y��, ��initial condition���p��QQ
        REAL*8::A(3),B(3)                       !A�MB����1*3�x�}(���p�߮ɥΨ�)
        REAL*8::E,F,G                           !�]�x�}���Ҧ����������P�@type

        INTEGER, PARAMETER::n=101
        REAL, DIMENSION(1:n)::t1,y1             !�x�}�j�p?  t1,y1�@��1~n��
        REAL, DIMENSION(1:n)::t2,y2
        REAL, DIMENSION(1:n)::t3,y
        REAL::Left=0.0, Right=10.0              !t�b��ɭȳ]��0~10
        REAL::increment                         !delta t
        INTEGER::i,j                            !�j���

        increment=(Right-Left)/(REAL(n)-1)      !���q

        t1(1)=0.0                               !�Ĥ@�ӰO���I�]���ɶ���0
        t2(1)=0.0
        t3(1)=0.0

        DO i=2,n                                !t(2)=t(1)+delta_t
           t1(i)=t1(i-1)+increment
           t2(i)=t2(i-1)+increment
           t3(i)=t3(i-1)+increment
        END DO



        WRITE(*,*)"Damping System--ODE: my''+cy'+ky=0"
	WRITE(*,*)"please enter the coefficients and initial condition of the damping ODE"
	WRITE(*,*)"mass: m="                              !m=10kg
	READ(*,*)m
	WRITE(*,*)"damping factor: c="                    !c=100,60,10kg/sec
	READ(*,*)c
	WRITE(*,*)"spring constant: k="                   !k=90N/m (�S�O����쪺��)
	READ(*,*)k
	WRITE(*,*)"initial condition: y(0)=k0, k0="       !k0=0.16m
	READ(*,*)k0
	WRITE(*,*)"initial condition: y'(0)=k1, k1="      !k1=0
	READ(*,*)k1

	D=c**2-4*m*k
	root1=-c/(2*m)+SQRT(D)/(2*m)
	root2=-c/(2*m)-SQRT(D)/(2*m)
	y1=exp(root1*t1)
	y2=exp(root2*t2)

        OPEN(unit=7,file="data.d",status="UNKNOWN")


	IF(D>0) THEN
	        WRITE(*,*)"CASE1: Overdamping"
        !-------#���p��: root1 ������ root2------------------------------
                E=1
                F=1
                A=(/E,F,k0/)            !C1+C2=k0
                B=(/root1,root2,k1/)    !�f_1*C1+�f_2*C2=k1
                B=B(1)*A-B              !�[����h�k
                B=B/B(2)
                A=A-A(2)*B
                A=A/A(1)                !���I�h�l���٬O�g�F(�]��A(1)=1)
                C1=A(3)
                C2=B(3)
                y=C1*y1+C2*y2

	ELSEIF(D==0) THEN
		WRITE(*,*)"CASE2: Critical damping"
		E=1                     !y=(C1+C2*t)*exp(�f*t)
                F=0                     !y'=C1*�f*exp(�f*t)+C2*(exp(�f*t)+�f*t*exp(�f*t))
                G=1
                A=(/E,F,k0/)            !y(0)=C1=k0
                B=(/root1,G,k1/)        !y'(0)=�f*C1+C2=1
                B=B-A*B(1)

                C1=A(3)
                C2=B(3)
                y=C1*y1+C2*t2*y2

	ELSE
		WRITE(*,*)"CASE3: Underdamping"
		E=1
		F=0
                A=(/E,F,k0/)
                B=(/-c/(2*m),SQRT(-D)/(2*m),k1/)
                B=B-A*B(1)
                B=B/B(2)
                C1=A(3)
                C2=B(3)
                y=exp(-c/(2*m)*t1)*(C1*cos(SQRT(-D)/(2*m)*t1)+C2*sin(SQRT(-D)/(2*m)*t2))

	ENDIF


        !WRITE(*,*)"       t              y"    !��ܿù���check
        WRITE(7,*)"       t              y"

        DO j=1,n
           !WRITE(*,*)t3(j),y(j)    !��ܿù���check
           WRITE(7,*)t3(j),y(j)
        END DO

        CLOSE(7)


	STOP
END PROGRAM