        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:36 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MAKE_STRUCTURAL_LATTICE__genmod
          INTERFACE 
            SUBROUTINE MAKE_STRUCTURAL_LATTICE(PLANE,X_P,N1,N3)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(INOUT) :: PLANE
              REAL(KIND=8), INTENT(IN) :: X_P(3,4)
              INTEGER(KIND=4), INTENT(IN) :: N1
              INTEGER(KIND=4), INTENT(IN) :: N3
            END SUBROUTINE MAKE_STRUCTURAL_LATTICE
          END INTERFACE 
        END MODULE MAKE_STRUCTURAL_LATTICE__genmod
