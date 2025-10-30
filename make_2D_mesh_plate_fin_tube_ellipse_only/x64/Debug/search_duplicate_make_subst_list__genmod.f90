        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:37 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SEARCH_DUPLICATE_MAKE_SUBST_LIST__genmod
          INTERFACE 
            SUBROUTINE SEARCH_DUPLICATE_MAKE_SUBST_LIST(DIM,NNODE,NODE, &
     &SYS,SUBST_NID,DELTA)
              USE MOD_PARAMETERS
              INTEGER(KIND=4), INTENT(IN) :: NNODE
              INTEGER(KIND=4), INTENT(IN) :: DIM
              REAL(KIND=8), INTENT(IN) :: NODE(DIM,NNODE)
              TYPE (TYPE_SYS_SUBBOX), INTENT(IN) :: SYS
              INTEGER(KIND=4), INTENT(INOUT) :: SUBST_NID(NNODE)
              REAL(KIND=8), INTENT(IN) :: DELTA
            END SUBROUTINE SEARCH_DUPLICATE_MAKE_SUBST_LIST
          END INTERFACE 
        END MODULE SEARCH_DUPLICATE_MAKE_SUBST_LIST__genmod
