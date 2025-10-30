        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:36 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MAKE_2D_EDGE__genmod
          INTERFACE 
            SUBROUTINE MAKE_2D_EDGE(TUBE,FIN)
              USE MOD_PARAMETERS
              TYPE (TYPE_EDGE), INTENT(INOUT) :: TUBE(4)
              TYPE (TYPE_EDGE), INTENT(INOUT) :: FIN(4)
            END SUBROUTINE MAKE_2D_EDGE
          END INTERFACE 
        END MODULE MAKE_2D_EDGE__genmod
