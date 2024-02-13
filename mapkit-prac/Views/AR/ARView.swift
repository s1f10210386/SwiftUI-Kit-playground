//
//  ARView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/07.
//

import SwiftUI
import RealityKit
import ARKit
import Foundation
import CoreLocation

struct NavigationPoint {
    var latitude: Double
    var longitude: Double
}

struct ARContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        //水平面になったらセッションを開始する
        let session = arView.session
        let config = ARGeoTrackingConfiguration()
        config.planeDetection = .horizontal
        session.run(config)
        
        //ARの処理をcoordinatorで行うのでcoordinatorに情報を渡す
        context.coordinator.arView = arView
        //arviewにCoachingOvelayViewを追加する（setUpCoachingOverLay() はARView+Extensionファイルにあります）
        arView.setupCoachingOverlay(context.coordinator)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    //Coordinatorを作成
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate ,ARCoachingOverlayViewDelegate{
        var arView: ARView?
        let locationManager = CLLocationManager()
        var currentLocaion: CLLocation?
        var locationViewModel: LocationViewModel?
        var navigationPoints: [NavigationPoint] = [
            NavigationPoint(latitude: 35.78070433652879, longitude:139.72440327408145),
            NavigationPoint(latitude: 35.78030441938045, longitude:139.72451480324366),
            NavigationPoint(latitude: 35.779874583583975,longitude:139.72462563558756),
        ]
        
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
        
        //ユーザーのデバイスの位置情報を更新
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            self.currentLocaion = locations.first
        }
        //エラーが出た場合
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
        
        //コーチング終わったら呼び出される
        func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
            
            navigationPoints .forEach { point in //for文で１つずつオブジェクト化
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
            //            guard let coordinates = locationViewModel?.coordinates else { return }
            //            coordinates.forEach { point in //for文で１つずつオブジェクト化
            //                let coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            //                let geoAnchor = ARGeoAnchor(coordinate: coordinate)
            //                // 実機
            //#if !targetEnvironment(simulator)
            //                let anchorEntity = AnchorEntity(anchor: geoAnchor)
            //#else
            //                // シミュレータ
            //                let anchorEntity = AnchorEntity()
            //#endif
            //
            //                let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 1.0))
            //                anchorEntity.addChild(modelEntity)
            //
            //                arView?.session.add(anchor: geoAnchor) // 仮想オブジェクトをどこに固定するか決定
            //                arView?.scene.addAnchor(anchorEntity) // オブジェクトを実際に配置
            //
            //            }
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ARContentView()
    }
}
#endif


