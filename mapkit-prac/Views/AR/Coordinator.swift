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
import Combine

struct NavigationPoint {
    var latitude: Double
    var longitude: Double
}

class Coordinator: NSObject, CLLocationManagerDelegate ,ARCoachingOverlayViewDelegate{
    var arView: ARView?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var locationViewModel: LocationViewModel?
    private var cancellables = Set<AnyCancellable>()

    init(locationViewModel: LocationViewModel) {
        self.locationViewModel = locationViewModel
    }

    //    init(locationViewModel: LocationViewModel? = nil) {
    //        self.locationViewModel = locationViewModel
    //        super.init()
    //        setupLocationManager()
    //        setupBindings()
    //    }

    func debugLocationViewModel() {
        let address = Unmanaged.passUnretained(self).toOpaque()
        print("LocationViewModelのインスタンスアドレス: \(address)")
        // locationViewModelがnilではないことを確認
        if let viewModel = locationViewModel {
            // coordinatesが空でないことを確認
            if !viewModel.coordinates.isEmpty {
                print("デバッグ: 現在の座標データは以下の通りです。")
                for coordinate in viewModel.coordinates {
                    print("緯度: \(coordinate.latitude), 経度: \(coordinate.longitude)")
                }
            } else {
                // coordinatesが空の場合
                print("デバッグ: 座標データは空です。")
            }
        } else {
            // locationViewModelがnilの場合
            print("デバッグ: locationViewModelは利用できません。")
        }
    }


    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }

    private func setupBindings() {
        locationViewModel?.$coordinates
            .sink(receiveValue: { [weak self] coordinates in
                self?.updateARView(with: coordinates)
            })
            .store(in: &cancellables)
    }

    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // コーチングオーバーレイが非アクティブになったら、最新の座標でARビューを更新する
        if let coordinates = self.locationViewModel?.coordinates {
            updateARView(with: coordinates)
        } else {
            print("最新の座標データがまだ利用可能ではありません。")
        }
    }
    
    
    private func updateARView(with coordinates: [CLLocationCoordinate2D]) {
        
        //表示したい場所の緯度と経度を入力(とりあえず赤羽公園)
        let start = CLLocationCoordinate2D(latitude: 35.7794403213241, longitude: 139.72490198235678)
        let end = CLLocationCoordinate2D(latitude: 35.77814635695832, longitude: 139.72507954093481)
        
        //start
        let geoAnchor = ARGeoAnchor(coordinate: start)
#if !targetEnvironment(simulator)
        let anchorEntity = AnchorEntity(anchor: geoAnchor)
#else
        let anchorEntity = AnchorEntity()
#endif
        let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 3.0))
        anchorEntity.addChild(modelEntity)
        
        arView?.session.add(anchor: geoAnchor) //仮想オブジェクトをどこに固定するか決定
        arView?.scene.addAnchor(anchorEntity) //オブジェクトを実際に配置
        
        //end
        let geoAnchor2 = ARGeoAnchor(coordinate: end)
#if !targetEnvironment(simulator)
        let anchorEntity2 = AnchorEntity(anchor: geoAnchor2)
#else
        let anchorEntity2 = AnchorEntity()
#endif
        let modelEntity2 = ModelEntity(mesh: MeshResource.generateBox(size: 3.0))
        anchorEntity2.addChild(modelEntity2)
        
        arView?.session.add(anchor: geoAnchor2) //仮想オブジェクトをどこに固定するか決定
        arView?.scene.addAnchor(anchorEntity2) //オブジェクトを実際に配置
        
        
        
        //線のやーーつ
//        let geoAnchor3 = ARGeoAnchor(coordinate:)
        //平面
        let planeMesh = MeshResource.generatePlane(width: 0.05, depth: 10)
        //赤色
        let material = SimpleMaterial(color: .red, isMetallic: false)
        //オブジェのエンティティ完成
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        
        
        
        DispatchQueue.main.async {
            coordinates.forEach { coordinate in
                let geoAnchor = ARGeoAnchor(coordinate: coordinate) //固定点
#if !targetEnvironment(simulator)
                let anchorEntity = AnchorEntity(anchor: geoAnchor) //オブジェクトの枠組み
#else
                let anchorEntity = AnchorEntity()
#endif
                let modelEntity = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.5)) //オブジェ
                let material = SimpleMaterial(color: .blue, isMetallic: false)
                modelEntity.components[ModelComponent.self]?.materials = [material]
                anchorEntity.addChild(modelEntity)

                self.arView?.session.add(anchor: geoAnchor) //仮想オブジェクトをどこに固定するか決定
                self.arView?.scene.addAnchor(anchorEntity)
            }

        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}
//        navigationPoints .forEach { point in //for文で１つずつオブジェクト化
//            let coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
//            let geoAnchor = ARGeoAnchor(coordinate: coordinate)
//            // 実機
//#if !targetEnvironment(simulator)
//            let anchorEntity = AnchorEntity(anchor: geoAnchor)
//#else
//            // シミュレータ
//            let anchorEntity = AnchorEntity()
//#endif
//
//            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 1.0))
//            anchorEntity.addChild(modelEntity)
//
//            arView?.session.add(anchor: geoAnchor) // 仮想オブジェクトをどこに固定するか決定
//            arView?.scene.addAnchor(anchorEntity) // オブジェクトを実際に配置


