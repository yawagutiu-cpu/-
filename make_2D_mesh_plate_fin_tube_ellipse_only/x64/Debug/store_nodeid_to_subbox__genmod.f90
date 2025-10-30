        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:37 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE STORE_NODEID_TO_SUBBOX__genmod
          INTERFACE 
            SUBROUTINE STORE_NODEID_TO_SUBBOX(DIM,NNODE,NODE,SYS_BOX)
              USE MOD_PARAMETERS
              INTEGER(KIND=4), INTENT(IN) :: NNODE
              INTEGER(KIND=4), INTENT(IN) :: DIM
              REAL(KIND=8), INTENT(IN) :: NODE(DIM,NNODE)
              TYPE (TYPE_SYS_SUBBOX) :: SYS_BOX
            END SUBROUTINE STORE_NODEID_TO_SUBBOX
          END INTERFACE 
        END MODULE STORE_NODEID_TO_SUBBOX__genmod
