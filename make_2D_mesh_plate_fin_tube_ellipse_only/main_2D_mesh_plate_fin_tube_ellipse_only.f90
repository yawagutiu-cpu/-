!  make_2D_mesh_plate_fin_tube_ellipse_only.f90 
!
!  関数:
!  make_2D_mesh_plate_fin_tube_ellipse_only - コンソール・アプリケーションのエントリーポイント。
!

!****************************************************************************
!
!  プログラム: make_2D_mesh_plate_fin_tube_ellipse_only
!
!  目的:  コンソール・アプリケーションのエントリーポイント。
!
!****************************************************************************

    program make_2D_mesh_plate_fin_tube_ellipse_only

    use mod_parameters
    implicit none

    ! 変数
    type(type_edge) :: edge_tube(4), edge_fin(4)  !> tubeとfinを4つのエッジに分割して作成
    type(type_mesh) :: plane(2,4)      !> 平面データのメッシュ
    type(type_mesh) :: mesh_2D         !> planeの面データを全てまとめたメッシュデータ
    type(type_mesh) :: mesh_2D_tube, mesh_2D_fin !> それぞれの要素ごとの2Dメッシュ
    type(type_mesh) :: solid_tube, solid_fin     !> ソリッドデータ
    type(type_mesh) :: solid
    integer :: i,j
    
    ! make_2D_mesh_plate_fin_tube_ellipse_only の本文
    !> データの読み込み
    call input
    !> 出力先のディレクトリを作成
    call system('mkdir output')
    !> エッジデータの作成 (エッジデータをコードで頑張って作る必要がある)
    call make_2D_edge(edge_tube,edge_fin)
    call output_paraview_edge(edge_tube,edge_fin) !> 確認用
    
    !> 以降は基本的に枠組みを利用してメッシュを生成できる
    !> 面データの作成
    do i=1, 4
      call make_2D_plane(edge_tube(i),plane(1,i),1)
      call make_2D_plane(edge_fin(i),plane(2,i),2)
    end do
    
    !> 要素ごとの2Dメッシュの作成
    call initialize_mesh_square(mesh_2D_tube)
    call initialize_mesh_square(mesh_2D_fin)
    do i=1, 4
      call integration_2D_mesh(plane(1,i),mesh_2D_tube)
    end do
    do i=1, 4
      call integration_2D_mesh(plane(2,i),mesh_2D_fin)
    end do
    call merge_duplicate_nodes(mesh_2D_tube)
    call merge_duplicate_nodes(mesh_2D_fin)
    
    !> 面データを集める
    call initialize_mesh_square(mesh_2D)
    !do i=1, 4
    !  do j=1, 2
    !    call integration_2D_mesh(plane(j,i),mesh_2D)
    !  end do
    !end do
    call integration_2D_mesh(mesh_2D_tube,mesh_2D)
    call integration_2D_mesh(mesh_2D_fin,mesh_2D)
    call output_mesh_paraview(mesh_2D,'integration_of_mesh_2D.vtu')
    
    !> 面データの重複点をマージする
    call merge_duplicate_nodes(mesh_2D)
    call output_mesh_paraview(mesh_2D,'after_merge_mesh_2D.vtu')
    
    !> 全体の2Dメッシュがここまでで完成
    
    
    !> 面データからソリッドデータを作成する
    call initialize_mesh_hex(solid_tube)
    call initialize_mesh_hex(solid_fin)
    
    call make_solid_by_2Dmesh&
      (solid_tube,mesh_2D_tube,t_tube_m,t_tube_p,t_mesh)
    call make_solid_by_2Dmesh&
      (solid_fin,mesh_2D_fin,t_fin_m,t_fin_p,t_mesh)
    
    !> 全体メッシュを統合
    call initialize_mesh_hex(solid)
    call integration_3D_mesh(solid_tube,solid)
    call integration_3D_mesh(solid_fin ,solid)
    
    !> 重複節点を削除
    call merge_duplicate_nodes(solid)
    
    !> ソリッドデータの出力
    call output_mesh_paraview(solid,'solid.vtu')
    call system('mkdir solid')
    call output_mesh_data(solid,'solid')
    
    print *
    print *, ' Finish : All Sections! '

    end program make_2D_mesh_plate_fin_tube_ellipse_only

