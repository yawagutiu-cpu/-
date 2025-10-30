        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:37 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE FIND_MINIMUM_INTER_NODAL_DISTANCE__genmod
          INTERFACE 
            SUBROUTINE FIND_MINIMUM_INTER_NODAL_DISTANCE(MESH,DELTA)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(IN) :: MESH
              REAL(KIND=8), INTENT(OUT) :: DELTA
            END SUBROUTINE FIND_MINIMUM_INTER_NODAL_DISTANCE
          END INTERFACE 
        END MODULE FIND_MINIMUM_INTER_NODAL_DISTANCE__genmod
