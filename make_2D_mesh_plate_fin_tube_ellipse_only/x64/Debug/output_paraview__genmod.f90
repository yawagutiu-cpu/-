        !COMPILER-GENERATED INTERFACE MODULE: Mon Oct 27 23:33:35 2025
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE OUTPUT_PARAVIEW__genmod
          INTERFACE 
            SUBROUTINE OUTPUT_PARAVIEW(DIM,NNODE,NBASE_FUNC,NELEM,NODE, &
     &ELEM,MAT_ID,MESH_TYPE,FILENAME)
              INTEGER(KIND=4), INTENT(IN) :: NELEM
              INTEGER(KIND=4), INTENT(IN) :: NBASE_FUNC
              INTEGER(KIND=4), INTENT(IN) :: NNODE
              INTEGER(KIND=4), INTENT(IN) :: DIM
              REAL(KIND=8), INTENT(IN) :: NODE(DIM,NNODE)
              INTEGER(KIND=4), INTENT(IN) :: ELEM(NBASE_FUNC,NELEM)
              INTEGER(KIND=4), INTENT(IN) :: MAT_ID(NELEM)
              INTEGER(KIND=4), INTENT(IN) :: MESH_TYPE
              CHARACTER(*), INTENT(IN) :: FILENAME
            END SUBROUTINE OUTPUT_PARAVIEW
          END INTERFACE 
        END MODULE OUTPUT_PARAVIEW__genmod
