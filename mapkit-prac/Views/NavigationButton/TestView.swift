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
    let start = CLLocation(latitude: 35.77943608852303, longitude: 139.72472107682103)
    let end = CLLocation(latitude: 35.778281564275574, longitude: 139.7262925072537)

    var body: some View {
        Text("2点間の距離: \(distanceBetweenTwoPoints())メートル")
            .padding()
        
        let midpointAndBearing = calculateMidpointAndBearing()
        Text("中点: \(midpointAndBearing.midpoint.latitude), \(midpointAndBearing.midpoint.longitude) 方角: \(midpointAndBearing.bearingRadians), マイナス: \(midpointAndBearing.minusRadians)")
            .padding()
        
        Button(action: {
            print(distanceBetweenTwoPoints())
        }) {
            Image(systemName: "gearshape.fill")
        }
        
        Button(action: {
            print(calculateMidpointAndBearing())
        }) {
            Image(systemName: "gearshape.fill")
        }
    }
    
    func distanceBetweenTwoPoints() -> CLLocationDistance {
        // 2点間の距離を計算
        let distance = start.distance(from: end)
        return distance
    }
    
    //中点と角度
    func calculateMidpointAndBearing() -> (midpoint: CLLocationCoordinate2D, bearingRadians: Double,minusRadians: Double) {
        // 中点の計算
        let midpointLatitude = (start.coordinate.latitude + end.coordinate.latitude) / 2
        let midpointLongitude = (start.coordinate.longitude + end.coordinate.longitude) / 2
        let midpoint = CLLocationCoordinate2D(latitude: midpointLatitude, longitude: midpointLongitude)
        
        // 方角の計算 (簡略化した計算例)
        let bearingRadians = atan2(end.coordinate.longitude - start.coordinate.longitude, end.coordinate.latitude - start.coordinate.latitude)
        
        let minusRadians = atan2(end.coordinate.latitude - start.coordinate.latitude, end.coordinate.longitude - start.coordinate.longitude)


        return (midpoint, bearingRadians,minusRadians)
    }
}

#Preview {
    TestView()
}
