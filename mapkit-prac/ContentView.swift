//
//  ContentView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/05.
//

import SwiftUI

struct ContentView: View {
    // LocationManagerのインスタンスを生成
    @ObservedObject var locationManager = LocationManager()
    
    // マップの表示
    var body: some View {
        MapView(region: $locationManager.region)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                // オーバーレイとして配置するボタン
                Button(action: {
                    if let currentLocation = locationManager.currentLocation {
                        print("現在の緯度: \(currentLocation.latitude), 緯度:\(currentLocation.longitude)")
                    }
                }) {
                    Image(systemName:"location.fill")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                ,
                alignment: .centerLastTextBaseline // オーバーレイの配置場所を指定
            )
        
        
    }
}

#Preview {
    ContentView()
}
