        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SEARCH_MAX_MIN_NODES__genmod
          INTERFACE 
            SUBROUTINE SEARCH_MAX_MIN_NODES(DIM,NNODE,NODE,MAX_X,MIN_X)
              INTEGER(KIND=4), INTENT(IN) :: NNODE
              INTEGER(KIND=4), INTENT(IN) :: DIM
              REAL(KIND=8), INTENT(IN) :: NODE(DIM,NNODE)
              REAL(KIND=8), INTENT(OUT) :: MAX_X(DIM)
              REAL(KIND=8), INTENT(OUT) :: MIN_X(DIM)
            END SUBROUTINE SEARCH_MAX_MIN_NODES
          END INTERFACE 
        END MODULE SEARCH_MAX_MIN_NODES__genmod
