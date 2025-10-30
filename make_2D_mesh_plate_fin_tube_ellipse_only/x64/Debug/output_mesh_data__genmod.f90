        !COMPILER-GENERATED INTERFACE MODULE: Tue Oct 28 00:15:33 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE OUTPUT_MESH_DATA__genmod
          INTERFACE 
            SUBROUTINE OUTPUT_MESH_DATA(MESH,DIR)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(IN) :: MESH
              CHARACTER(*), INTENT(IN) :: DIR
            END SUBROUTINE OUTPUT_MESH_DATA
          END INTERFACE 
        END MODULE OUTPUT_MESH_DATA__genmod
