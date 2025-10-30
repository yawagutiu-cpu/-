        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE COPY_MESH__genmod
          INTERFACE 
            SUBROUTINE COPY_MESH(MESH,MESH_C)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(IN) :: MESH
              TYPE (TYPE_MESH), INTENT(INOUT) :: MESH_C
            END SUBROUTINE COPY_MESH
          END INTERFACE 
        END MODULE COPY_MESH__genmod
