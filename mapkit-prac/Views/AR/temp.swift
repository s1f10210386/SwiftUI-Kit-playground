////
////  Coordinator.swift
////  ARKit-prac
////
////  Created by 金澤帆高 on 2024/02/12.
////
//
//import Foundation
//import RealityKit
//import ARKit
//import CoreLocation
//import Combine
//
//struct NavigationPoint {
//    var latitude: Double
//    var longitude: Double
//}
//
//class Coordinator: NSObject, CLLocationManagerDelegate ,ARCoachingOverlayViewDelegate{
//    var arView: ARView?
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//    var locationViewModel: LocationViewModel?
//    private var cancellables = Set<AnyCancellable>()
//    
//    init(locationViewModel: LocationViewModel) {
//        self.locationViewModel = locationViewModel
//    }
//    
//    //    init(locationViewModel: LocationViewModel? = nil) {
//    //        self.locationViewModel = locationViewModel
//    //        super.init()
//    //        setupLocationManager()
//    //        setupBindings()
//    //    }
//    
//    func debugLocationViewModel() {
//        let address = Unmanaged.passUnretained(self).toOpaque()
//        print("LocationViewModelのインスタンスアドレス: \(address)")
//        // locationViewModelがnilではないことを確認
//        if let viewModel = locationViewModel {
//            // coordinatesが空でないことを確認
//            if !viewModel.coordinates.isEmpty {
//                print("デバッグ: 現在の座標データは以下の通りです。")
//                for coordinate in viewModel.coordinates {
//                    print("緯度: \(coordinate.latitude), 経度: \(coordinate.longitude)")
//                }
//            } else {
//                // coordinatesが空の場合
//                print("デバッグ: 座標データは空です。")
//            }
//        } else {
//            // locationViewModelがnilの場合
//            print("デバッグ: locationViewModelは利用できません。")
//        }
//    }
//    
//    
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.requestLocation()
//        locationManager.startUpdatingLocation()
//    }
//    
//    private func setupBindings() {
//        locationViewModel?.$coordinates
//            .sink(receiveValue: { [weak self] coordinates in
//                self?.updateARView(with: coordinates)
//            })
//            .store(in: &cancellables)
//    }
//    
//    private func updateARView(with coordinates: [CLLocationCoordinate2D]) {
//        DispatchQueue.main.async {
//            coordinates.forEach { coordinate in
//                let geoAnchor = ARGeoAnchor(coordinate: coordinate)
//#if !targetEnvironment(simulator)
//                let anchorEntity = AnchorEntity(anchor: geoAnchor)
//#else
//                let anchorEntity = AnchorEntity()
//#endif
//                let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.1))
//                anchorEntity.addChild(modelEntity)
//                
//                self.arView?.session.add(anchor: geoAnchor) //仮想オブジェクトをどこに固定するか決定
//                self.arView?.scene.addAnchor(anchorEntity)
//            }
//            
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.currentLocation = locations.first
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//    
//    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
//        // コーチングオーバーレイが非アクティブになったら、最新の座標でARビューを更新する
//        if let coordinates = self.locationViewModel?.coordinates {
//            updateARView(with: coordinates)
//        } else {
//            print("最新の座標データがまだ利用可能ではありません。")
//        }
//    }
//    
//}
////        navigationPoints .forEach { point in //for文で１つずつオブジェクト化
////            let coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
////            let geoAnchor = ARGeoAnchor(coordinate: coordinate)
////            // 実機
////#if !targetEnvironment(simulator)
////            let anchorEntity = AnchorEntity(anchor: geoAnchor)
////#else
////            // シミュレータ
////            let anchorEntity = AnchorEntity()
////#endif
////
////            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 1.0))
////            anchorEntity.addChild(modelEntity)
////
////            arView?.session.add(anchor: geoAnchor) // 仮想オブジェクトをどこに固定するか決定
////            arView?.scene.addAnchor(anchorEntity) // オブジェクトを実際に配置
//
