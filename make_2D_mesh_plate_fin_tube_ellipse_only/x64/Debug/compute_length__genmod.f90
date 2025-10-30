        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:37 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE COMPUTE_LENGTH__genmod
          INTERFACE 
            SUBROUTINE COMPUTE_LENGTH(N1,N2,DIM,L)
              INTEGER(KIND=4), INTENT(IN) :: DIM
              REAL(KIND=8), INTENT(IN) :: N1(DIM)
              REAL(KIND=8), INTENT(IN) :: N2(DIM)
              REAL(KIND=8), INTENT(OUT) :: L
            END SUBROUTINE COMPUTE_LENGTH
          END INTERFACE 
        END MODULE COMPUTE_LENGTH__genmod
