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
    @ObservedObject var userInput = TextBoxViewModel()
    @EnvironmentObject var locationviewModel: LocationViewModel
    
    
    
    var body: some View {
        
        MapView(route: $locationviewModel.route)
            .edgesIgnoringSafeArea(.all)
        
            .overlay(
                Button(action: {
                    locationviewModel.searchRouteToTokyoStation()
                }) {
                    VStack{
                        Text("赤羽公園への経路を検索")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        
                        ForEach(locationviewModel.coordinates.indices, id: \.self) { index in
                            let coordinate = locationviewModel.coordinates[index]
                            Text("座標 \(index): 緯度 \(coordinate.latitude), 経度 \(coordinate.longitude)")
                        }
                        
                    }
                    
                }
                    .position(x: UIScreen.main.bounds.width / 2, y: 50) // 位置を明示的に指定
                
            )
        
        
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationViewModel())
    }
}
