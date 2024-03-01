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
    var referenceObjects: Set<ARReferenceObject> = []
    
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
        
        DispatchQueue.main.async {
            for i in 0..<coordinates.count - 1 {
                let start = coordinates[i]
                let end = coordinates[i + 1]
                
                //ラジアン計算
                let bearingRadians = atan2(end.longitude - start.longitude, end.latitude - start.latitude)
                
                if let modelEntity = try? Entity.loadModel(named: "arrow") {
                    modelEntity.scale = SIMD3<Float>(0.1, 0.1, 0.1)
                    modelEntity.transform.rotation = simd_quatf(angle: .pi/2 - Float(bearingRadians), axis: [0, 1, 0])
                    
                    let geoAnchor = ARGeoAnchor(coordinate: start)

                    
                    #if !targetEnvironment(simulator)
                    let anchorEntity = AnchorEntity(anchor: geoAnchor) // 適切な位置に配置
                    #else
                    
                    //シミュレーター
                    let anchorEntity = AnchorEntity()
                    #endif

                    anchorEntity.addChild(modelEntity)
                    
                    self.arView?.session.add(anchor: geoAnchor)
                    self.arView?.scene.addAnchor(anchorEntity)
                    
                    
                }
                
            }
            
//            if let posts = self.postsVM?.posts {
                for post in posts {
                    let textMesh = MeshResource.generateText(
                        post.content,
                        extrusionDepth: 0.1,
                        font: .systemFont(ofSize: 2),
                        containerFrame: CGRect.zero,
                        alignment: .center,
                        lineBreakMode: .byCharWrapping
                    )
                    
                    let zahyo = post.coordinate
                    //オブジェクトの表面の外観
                    let material = SimpleMaterial(color: .black, isMetallic: false)
                    let model = ModelEntity(mesh: textMesh, materials: [material])
                    
                    let locationWithAltitude = CLLocation(coordinate: zahyo, altitude: 10.0, horizontalAccuracy: kCLLocationAccuracyBest, verticalAccuracy: kCLLocationAccuracyBest, timestamp: Date())
                            
                    // ARGeoAnchorをCLLocationから作成
                    let textAnchor = ARGeoAnchor(coordinate: locationWithAltitude.coordinate, altitude: locationWithAltitude.altitude)
                    
                    //AnchorEntityはオブジェクトをどこに置くのか指定するためのもの
//                    let textAnchor = ARGeoAnchor(coordinate: zahyo)
                    
#if !targetEnvironment(simulator)
                    let textAnchorEntity = AnchorEntity(anchor: textAnchor)
#else
                    
                    //シミュレーター
                    let textAnchorEntity = AnchorEntity()
#endif
                    
                    textAnchorEntity.addChild(model)
                    
                    self.arView?.session.add(anchor: textAnchor)
                    self.arView?.scene.addAnchor(textAnchorEntity)
                    
                }
//            }
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            self.currentLocation = locations.first
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
        
    }
}
