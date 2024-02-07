//
//  ARView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/07.
//


import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var viewModel: TextBoxViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        //オブジェクトの形状
        //        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        //        let mesh = MeshResource.generatePlane(width: 0.1, height: 0.1)
        let mesh = MeshResource.generateText(
            viewModel.userInput,
            extrusionDepth: 0.1,
            font: .systemFont(ofSize: 1),
            containerFrame: CGRect.zero,
            alignment: .center,
            lineBreakMode: .byCharWrapping
        )
        //オブジェクトの表面の外観
        //        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
        let material = SimpleMaterial(color: .white, isMetallic: false)
        
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.transform.translation.y = 0.05
        
        //AnchorEntityはオブジェクトをどこに置くのか指定するためのもの
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        
        //anchorの子階層に立方体のモデルを追加
        anchor.children.append(model)
        
        //ARViewのsceneにアンカー追加
        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

