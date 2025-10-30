        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:36 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE CORRECT_STRUCTURAL_LATTICES_WITH_EDGE__genmod
          INTERFACE 
            SUBROUTINE CORRECT_STRUCTURAL_LATTICES_WITH_EDGE(EDGE,PLANE)
              USE MOD_PARAMETERS
              TYPE (TYPE_EDGE), INTENT(IN) :: EDGE
              TYPE (TYPE_MESH), INTENT(INOUT) :: PLANE
            END SUBROUTINE CORRECT_STRUCTURAL_LATTICES_WITH_EDGE
          END INTERFACE 
        END MODULE CORRECT_STRUCTURAL_LATTICES_WITH_EDGE__genmod
