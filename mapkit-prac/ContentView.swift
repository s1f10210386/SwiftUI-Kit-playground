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
    
    var body: some View {
        MapView(region: $locationManager.region)
            .edgesIgnoringSafeArea(.all)
        
            .overlay(
                PostButtonView(),
                alignment: .centerLastTextBaseline //ボタンを中央下に
                
            )
        
            .overlay(
                NavigationButtonView(),
                alignment: .topTrailing // ボタン達を右上に
            )
    }
    
}

#Preview {
    ContentView()
}
