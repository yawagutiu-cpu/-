        !COMPILER-GENERATED INTERFACE MODULE: Tue Oct 28 00:04:43 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MAKE_SOLID_BY_2DMESH__genmod
          INTERFACE 
            SUBROUTINE MAKE_SOLID_BY_2DMESH(SOLID,MESH_2D,T_M,T_P,      &
     &DELTA_T)
              USE MOD_PARAMETERS
              TYPE (TYPE_MESH), INTENT(INOUT) :: SOLID
              TYPE (TYPE_MESH), INTENT(IN) :: MESH_2D
              REAL(KIND=8), INTENT(IN) :: T_M
              REAL(KIND=8), INTENT(IN) :: T_P
              REAL(KIND=8), INTENT(IN) :: DELTA_T
            END SUBROUTINE MAKE_SOLID_BY_2DMESH
          END INTERFACE 
        END MODULE MAKE_SOLID_BY_2DMESH__genmod
