//
//  Second.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI
import CoreLocation

struct TestView: View {
    // 2点の緯度経度を示すサンプル
    let location1 = CLLocation(latitude: 35.658581, longitude: 139.745433) // 東京タワー
    let location2 = CLLocation(latitude: 35.710063, longitude: 139.8107) // 東京スカイツリー

    var body: some View {
        Text("2点間の距離: \(distanceBetweenTwoPoints())メートル")
            .padding()
    }
    
    func distanceBetweenTwoPoints() -> CLLocationDistance {
        // 2点間の距離を計算
        let distance = location1.distance(from: location2)
        return distance
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
