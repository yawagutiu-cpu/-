        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE GET_LENGTH_ELLIPSE__genmod
          INTERFACE 
            SUBROUTINE GET_LENGTH_ELLIPSE(X,Y,A,B,T,DT,LENGTH,X_ELLIPSE)
              REAL(KIND=8), INTENT(IN) :: X
              REAL(KIND=8), INTENT(IN) :: Y
              REAL(KIND=8), INTENT(IN) :: A
              REAL(KIND=8), INTENT(IN) :: B
              REAL(KIND=8), INTENT(IN) :: T
              REAL(KIND=8), INTENT(IN) :: DT
              REAL(KIND=8), INTENT(OUT) :: LENGTH
              REAL(KIND=8), INTENT(OUT) :: X_ELLIPSE(2)
            END SUBROUTINE GET_LENGTH_ELLIPSE
          END INTERFACE 
        END MODULE GET_LENGTH_ELLIPSE__genmod
