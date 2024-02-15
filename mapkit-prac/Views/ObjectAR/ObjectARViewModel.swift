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

    @Published var referenceObjects: Set<ARReferenceObject> = []

    init() {
        loadReferenceObjects()
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
        configuration.detectionObjects = referenceObjects
        arView.session.run(configuration)
    }
}
