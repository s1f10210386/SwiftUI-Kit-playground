//
//  Coordinator.swift
//  ARKit-prac
//
//  Created by 金澤帆高 on 2024/02/12.
//

import Foundation
import RealityKit
import ARKit
import CoreLocation

class Coordinator: NSObject, CLLocationManagerDelegate ,ARCoachingOverlayViewDelegate{
    var arView: ARView?
    let locationManager = CLLocationManager()
    var currentLocaion: CLLocation?
    var locationViewModel: LocationViewModel?
    
    init(locationViewModel: LocationViewModel? = nil) {
        self.locationViewModel = locationViewModel
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    //    init(locationViewModel: LocationViewModel) {
    //        self.locationViewModel = locationViewModel
    //    }
    //
    //    //ここでlocationManagerの諸々初期設定
    //    override init(){
    //        super.init()
    //        //位置情報の更新を受け取れるようにする
    //        locationManager.delegate = self
    //        //小さな移動でも位置情報の更新を行うように
    //        locationManager.distanceFilter = kCLDistanceFilterNone
    //        //した二つで位置情報の取得を開始！
    //        locationManager.requestLocation()
    //        locationManager.startUpdatingLocation()
    //
    //    }
    
    //ユーザーのデバイスの位置情報を更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocaion = locations.first
    }
    //エラーが出た場合
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        
        guard let coordinates = locationViewModel?.coordinates else { return }
        coordinates.forEach { point in //for文で１つずつオブジェクト化
            let coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            let geoAnchor = ARGeoAnchor(coordinate: coordinate)
            // 実機
#if !targetEnvironment(simulator)
            let anchorEntity = AnchorEntity(anchor: geoAnchor)
#else
            // シミュレータ
            let anchorEntity = AnchorEntity()
#endif
            
            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 1.0))
            anchorEntity.addChild(modelEntity)
            
            arView?.session.add(anchor: geoAnchor) // 仮想オブジェクトをどこに固定するか決定
            arView?.scene.addAnchor(anchorEntity) // オブジェクトを実際に配置
            
        }
    }
    
    
    //    //表示したい場所の緯度と経度を入力(とりあえず赤羽公園)
    //    let coordinate = CLLocationCoordinate2D(latitude: 35.78029531129428,longitude:139.72451471491374)
    //    let geoAnchor = ARGeoAnchor(coordinate: coordinate)
    //    //実機
    //#if !targetEnvironment(simulator)
    //    let anchorEntity = AnchorEntity(anchor: geoAnchor)
    //#else
    //    //シュミレータ
    //    let anchorEntity = AnchorEntity()
    //#endif
    //
    //    let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.5))
    //    anchorEntity.addChild(modelEntity)
    //
    //    arView?.session.add(anchor: geoAnchor) //仮想オブジェクトをどこに固定するか決定
    //    arView?.scene.addAnchor(anchorEntity) //オブジェクトを実際に配置
    //
    
    
    
    
    
    
    
    
    
    
    
    
    //    func createSphereEntity() -> ModelEntity{
    //        let sphereMesh = MeshResource.generateSphere(radius: 0.1)
    //        let spherematerial = SimpleMaterial(color: .red, isMetallic: true)
    //        let entity = ModelEntity(mesh: sphereMesh, materials: [spherematerial])
    //        return entity
    //    }
    //
    //    func placeNavigation(in arView: ARView,with coordinates: [CLLocationCoordinate2D]){
    //        for coordinate in coordinates {
    //            let geoAnchor = ARGeoAnchor(coordinate: coordinate)
    //            let anchorEntity = AnchorEntity(anchor: geoAnchor)
    //            let naviEntity = createSphereEntity()
    //            anchorEntity.addChild(naviEntity)
    //
    //            arView.session.add(anchor: geoAnchor)
    //            arView.scene.addAnchor(anchorEntity)
    //        }
    //
    //
    
    //    }
    
}
