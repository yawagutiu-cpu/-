        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:37 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE UPDATE_NODE_ID_BY_SUBST_NID_LIST__genmod
          INTERFACE 
            SUBROUTINE UPDATE_NODE_ID_BY_SUBST_NID_LIST(MESH,SUBST_NID)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(INOUT) :: MESH
              INTEGER(KIND=4), INTENT(IN) :: SUBST_NID(MESH%NNODE)
            END SUBROUTINE UPDATE_NODE_ID_BY_SUBST_NID_LIST
          END INTERFACE 
        END MODULE UPDATE_NODE_ID_BY_SUBST_NID_LIST__genmod
