        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE GET_SHAPE_FUNC__genmod
          INTERFACE 
            SUBROUTINE GET_SHAPE_FUNC(SHAPE_FUNC,N1,N3)
              INTEGER(KIND=4), INTENT(IN) :: N3
              INTEGER(KIND=4), INTENT(IN) :: N1
              REAL(KIND=8), INTENT(INOUT) :: SHAPE_FUNC(4,N1,N3)
            END SUBROUTINE GET_SHAPE_FUNC
          END INTERFACE 
        END MODULE GET_SHAPE_FUNC__genmod
