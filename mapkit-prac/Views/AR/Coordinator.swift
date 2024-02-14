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
    
    var coordinates: [NavigationPoint] = [
        NavigationPoint(latitude: 35.779412099999995, longitude: 139.72489670000002),
        NavigationPoint(latitude: 35.779597300000006, longitude: 139.7247337),]
    
    init(locationViewModel: LocationViewModel) {
        self.locationViewModel = locationViewModel
    }
    
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
    
//    func setupBindings() {
//        locationViewModel?.$coordinates
//            .sink(receiveValue: { [weak self] coordinates in
//                self?.updateARView(with: coordinates)
//            })
//            .store(in: &cancellables)
//    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //表示したい場所の緯度と経度を入力(とりあえず赤羽公園)
        let coordinate = CLLocationCoordinate2D(latitude: 35.777672, longitude:139.724575)
        let geoAnchor = ARGeoAnchor(coordinate: coordinate)
        let anchorEntity = AnchorEntity(anchor: geoAnchor)
        let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.5))
        anchorEntity.addChild(modelEntity)

        arView?.session.add(anchor: geoAnchor) //仮想オブジェクトをどこに固定するか決定
        arView?.scene.addAnchor(anchorEntity) //オブジェクトを実際に配置
        
    }
}
