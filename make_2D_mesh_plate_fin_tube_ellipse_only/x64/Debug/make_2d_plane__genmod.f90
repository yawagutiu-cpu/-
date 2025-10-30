        !COMPILER-GENERATED INTERFACE MODULE: Tue Oct 28 01:13:12 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MAKE_2D_PLANE__genmod
          INTERFACE 
            SUBROUTINE MAKE_2D_PLANE(EDGE,PLANE,MAT_ID)
              USE MOD_PARAMETERS
              TYPE (TYPE_EDGE), INTENT(IN) :: EDGE
              TYPE (TYPE_MESH), INTENT(OUT) :: PLANE
              INTEGER(KIND=4), INTENT(IN) :: MAT_ID
            END SUBROUTINE MAKE_2D_PLANE
          END INTERFACE 
        END MODULE MAKE_2D_PLANE__genmod
