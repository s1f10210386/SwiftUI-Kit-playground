//
//  3DScannViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/11.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
        // 物体認識用の参照物体を読み込む
        guard let objectURL = Bundle.main.url(forResource: "cup", withExtension: "arobject") else { return }
        guard let referenceObject = ARReferenceObject(archiveURL: objectURL, previewImage: nil) else { return }
        
        // ARセッションの設定
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionObjects = [referenceObject]
        sceneView.session.run(configuration)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ARセッションを開始
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // ARセッションを一時停止
        sceneView.session.pause()
    }
    
    // 物体が認識されたときの処理
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let objectAnchor = anchor as? ARObjectAnchor else { return }
        
        // ここでARオブジェクトを表示する処理を追加
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.05))
        sphereNode.position = SCNVector3Make(objectAnchor.transform.columns.3.x, objectAnchor.transform.columns.3.y, objectAnchor.transform.columns.3.z)
        
        DispatchQueue.main.async {
            node.addChildNode(sphereNode)
        }
    }
}
