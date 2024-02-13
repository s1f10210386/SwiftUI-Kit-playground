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


struct ARContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var locationVM: LocationViewModel
    
    //これによって渡されたlocationViewModelのインスタンスを内部で保持して、使用できる
    func makeCoordinator() -> Coordinator {
        Coordinator(locationViewModel: locationVM)
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        //水平面になったらセッションを開始する
        let session = arView.session
        let config = ARGeoTrackingConfiguration()
        config.planeDetection = .horizontal
        session.run(config)
    
        //arViewの内容をcoordinatorでいじれるように結びつけた。
        context.coordinator.arView = arView
        //arviewの拡張関数CoachingOvelayViewを呼び出す
        arView.setupCoachingOverlay(context.coordinator)
        
        //coordinatorのデバック関数を呼び出す
        context.coordinator.debugLocationViewModel()
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


