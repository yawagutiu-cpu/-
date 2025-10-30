        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE GET_ELLIPSE_POSITION__genmod
          INTERFACE 
            SUBROUTINE GET_ELLIPSE_POSITION(X_R,Y_R,RA,RB,T_S,T_E,N,NODE&
     &)
              INTEGER(KIND=4), INTENT(IN) :: N
              REAL(KIND=8), INTENT(IN) :: X_R
              REAL(KIND=8), INTENT(IN) :: Y_R
              REAL(KIND=8), INTENT(IN) :: RA
              REAL(KIND=8), INTENT(IN) :: RB
              REAL(KIND=8), INTENT(IN) :: T_S
              REAL(KIND=8), INTENT(IN) :: T_E
              REAL(KIND=8), INTENT(INOUT) :: NODE(3,N+1)
            END SUBROUTINE GET_ELLIPSE_POSITION
          END INTERFACE 
        END MODULE GET_ELLIPSE_POSITION__genmod
