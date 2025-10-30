        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:37 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SEARCH_MINIMUM_LENGTH_IN_ELEMENT__genmod
          INTERFACE 
            SUBROUTINE SEARCH_MINIMUM_LENGTH_IN_ELEMENT(NODE,DIM,NBASE, &
     &LENGTH)
              INTEGER(KIND=4), INTENT(IN) :: NBASE
              INTEGER(KIND=4), INTENT(IN) :: DIM
              REAL(KIND=8), INTENT(IN) :: NODE(DIM,NBASE)
              REAL(KIND=8), INTENT(OUT) :: LENGTH
            END SUBROUTINE SEARCH_MINIMUM_LENGTH_IN_ELEMENT
          END INTERFACE 
        END MODULE SEARCH_MINIMUM_LENGTH_IN_ELEMENT__genmod
