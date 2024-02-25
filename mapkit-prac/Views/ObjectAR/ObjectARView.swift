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
                
                //名刺
                //                if let imageAnchor = anchor as? ARImageAnchor {
                //
                ////                    let sphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .red, isMetallic: true)])
                //                    let plane = ModelEntity(mesh: .generatePlane(width: 0.2, height: 0.3))
                //
                //                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
                //                    anchorEntity.addChild(plane)
                
                if let imageAnchor = anchor as? ARImageAnchor {
                    // ボックスエンティティを生成し、画像テクスチャを適用する
                    let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.5, 0.5, 0.2)))
                    
                    if let texture = try? TextureResource.load(named: "Meishi") { // テクスチャ・リソースとして画像を読み込む
                        var imageMaterial = UnlitMaterial()
                        imageMaterial.baseColor = MaterialColorParameter.texture(texture) // アンリット・マテリアルのテクスチャに設定する
                        box.model?.materials = [imageMaterial] // ボックスのマテリアルに設定する
                    }
                    
                    // 生成したボックスをARImageAnchorに関連付けられたアンカーエンティティに追加する
                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
                    anchorEntity.addChild(box)
                    
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
