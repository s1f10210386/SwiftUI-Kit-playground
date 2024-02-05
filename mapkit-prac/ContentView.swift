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
            .overlay(VStack {
                Button(action: {
                    // 3Dボタンのアクション
                }) {
                    Image(systemName: "cube.transparent")
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                
                Button(action: {
                    // プロフィールボタンのアクション
                }) {
                    Image(systemName: "person.crop.circle.fill")
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                
                Button(action: {
                    // 設定ボタンのアクション
                }) {
                    Image(systemName: "gearshape.fill")
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
                
                .padding(.trailing, 20), // 画面の右側に余白を追加
                     alignment: .topTrailing // ボタン群を右上に配置
            )
    }
    
}

#Preview {
    ContentView()
}
