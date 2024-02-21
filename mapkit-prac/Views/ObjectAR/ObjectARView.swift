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
                
                //画像の時
                if let imageAnchor = anchor as? ARImageAnchor {
                    ////                    let imageTextMesh = MeshResource.generateText("Hi",
                    ////                                                             extrusionDepth: 0.1,
                    ////                                                             font: .systemFont(ofSize: 0.05),
                    ////                                                             containerFrame: CGRect(x: 0, y: 0, width: 0.2, height: 0.05),
                    ////                                                             alignment: .center,
                    ////                                                             lineBreakMode: .byWordWrapping)
                    ////                    let imageTextMaterial = SimpleMaterial(color: .white, isMetallic: false)
                    ////                    let imageTextEntity = ModelEntity(mesh: imageTextMesh, materials: [imageTextMaterial])
                    ////
                    //                    let anchorEntity1 = AnchorEntity(anchor: imageAnchor)
                    //
                    //                    anchorEntity1.addChild(imageTextEntity)
                    
                    
                    let sphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .red, isMetallic: true)])
                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
                    anchorEntity.addChild(sphere)
                    
                    DispatchQueue.main.async {
                        self.parent.viewModel.arView.scene.addAnchor(anchorEntity)
                    }
                }
                
                //物体認識
                guard let objectAnchor = anchor as? ARObjectAnchor else { continue }
                
                
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
