        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:59:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE INTEGRATION_2D_MESH__genmod
          INTERFACE 
            SUBROUTINE INTEGRATION_2D_MESH(PLANE,MESH)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(IN) :: PLANE
              TYPE (TYPE_MESH), INTENT(INOUT) :: MESH
            END SUBROUTINE INTEGRATION_2D_MESH
          END INTERFACE 
        END MODULE INTEGRATION_2D_MESH__genmod
