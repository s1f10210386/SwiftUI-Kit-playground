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
    @ObservedObject var viewModel : LocationViewModel
    
    
    var body: some View {
        
        MapView(route: $viewModel.route)
            .edgesIgnoringSafeArea(.all)
        
            .overlay(
                Button(action: {
                    viewModel.searchRouteToTokyoStation()
                    
                }) {
                    Text("赤羽公園への経路を検索")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
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

#Preview {
    ContentView(viewModel: LocationViewModel())
}
