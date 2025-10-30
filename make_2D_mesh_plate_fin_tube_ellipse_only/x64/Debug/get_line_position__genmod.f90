        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE GET_LINE_POSITION__genmod
          INTERFACE 
            SUBROUTINE GET_LINE_POSITION(X_S,X_E,N,NODE)
              INTEGER(KIND=4), INTENT(IN) :: N
              REAL(KIND=8), INTENT(IN) :: X_S(3)
              REAL(KIND=8), INTENT(IN) :: X_E(3)
              REAL(KIND=8), INTENT(INOUT) :: NODE(3,N+1)
            END SUBROUTINE GET_LINE_POSITION
          END INTERFACE 
        END MODULE GET_LINE_POSITION__genmod
