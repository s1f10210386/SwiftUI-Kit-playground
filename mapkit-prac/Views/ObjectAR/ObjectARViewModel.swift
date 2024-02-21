//
//  ObjectARViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/16.
//

import ARKit
import Combine
import RealityKit
import SwiftUI


class ObjectARViewModel: ObservableObject {
    var arView: ARView = ARView() // RealityKitのARView

    @Published var referenceImages: Set<ARReferenceImage> = []
    @Published var referenceObjects: Set<ARReferenceObject> = []

    init() {
        loadReferenceImages()
        loadReferenceObjects()
    }
    
    private func loadReferenceImages() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AppIcons", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        self.referenceImages = referenceImages
    }

    private func loadReferenceObjects() {
        // `.arobject`ファイルからARReferenceObjectを読み込む処理
        guard let referenceObjects = ARReferenceObject.referenceObjects(inGroupNamed: "Biore", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        self.referenceObjects = referenceObjects
    }

    func startARSession() {
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.detectionImages = referenceImages
        configuration.detectionObjects = referenceObjects
        
        arView.session.run(configuration)
    }
}
