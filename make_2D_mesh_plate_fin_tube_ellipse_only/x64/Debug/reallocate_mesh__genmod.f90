        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:36 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE REALLOCATE_MESH__genmod
          INTERFACE 
            SUBROUTINE REALLOCATE_MESH(MESH,NNODE,NELEM)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(INOUT) :: MESH
              INTEGER(KIND=4), INTENT(IN) :: NNODE
              INTEGER(KIND=4), INTENT(IN) :: NELEM
            END SUBROUTINE REALLOCATE_MESH
          END INTERFACE 
        END MODULE REALLOCATE_MESH__genmod
