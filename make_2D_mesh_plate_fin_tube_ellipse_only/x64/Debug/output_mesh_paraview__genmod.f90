        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:36 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE OUTPUT_MESH_PARAVIEW__genmod
          INTERFACE 
            SUBROUTINE OUTPUT_MESH_PARAVIEW(MESH,FNAME)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(IN) :: MESH
              CHARACTER(*), INTENT(IN) :: FNAME
            END SUBROUTINE OUTPUT_MESH_PARAVIEW
          END INTERFACE 
        END MODULE OUTPUT_MESH_PARAVIEW__genmod
