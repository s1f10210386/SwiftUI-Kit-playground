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


struct ARContentView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            // 閉じるボタン
            Button(action: {
                // ビューを閉じる
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            }
            .padding() // 必要に応じて調整
            .accessibilityLabel(Text("閉じる"))
        }
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
        arView.startGeoTrackingSession()
    
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


