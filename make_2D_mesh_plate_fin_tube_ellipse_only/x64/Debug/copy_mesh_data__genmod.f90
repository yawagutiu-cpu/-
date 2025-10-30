        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:36 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE COPY_MESH_DATA__genmod
          INTERFACE 
            SUBROUTINE COPY_MESH_DATA(MESH,MESH_COPY)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(IN) :: MESH
              TYPE (TYPE_MESH), INTENT(OUT) :: MESH_COPY
            END SUBROUTINE COPY_MESH_DATA
          END INTERFACE 
        END MODULE COPY_MESH_DATA__genmod
