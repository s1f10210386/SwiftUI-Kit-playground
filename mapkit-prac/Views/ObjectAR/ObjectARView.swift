//
//  ObjectAR.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/16.
//

import SwiftUI
import RealityKit
import ARKit


struct ObjectARContentView: View {
    var viewModel = ObjectARViewModel()

    var body: some View {
        VStack {
            ObjectARViewContainer(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            Button("Start AR Session") {
                viewModel.startARSession()
            }
        }
    }
}

struct ObjectARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ObjectARViewModel
    
    func makeUIView(context: Context) -> ARView {
        viewModel.arView.session.delegate = context.coordinator
        return viewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ObjectARViewContainer
        
        init(_ parent: ObjectARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let objectAnchor = anchor as? ARObjectAnchor else { continue }
                
                // RealityKitで球体を追加
                let sphere = ModelEntity(mesh: .generateSphere(radius: 0.05), materials: [SimpleMaterial(color: .red, isMetallic: true)])
                let anchorEntity = AnchorEntity(anchor: objectAnchor)
                anchorEntity.addChild(sphere)
                
                DispatchQueue.main.async {
                    self.parent.viewModel.arView.scene.addAnchor(anchorEntity)
                }
            }
        }
    }
}
