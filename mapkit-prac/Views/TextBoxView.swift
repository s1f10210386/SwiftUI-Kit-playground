//
//  MessageView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

struct TextBoxView: View {
    @EnvironmentObject var viewModel: TextBoxViewModel
    @ObservedObject var locationManager = LocationManager()

    
    var body: some View {
        VStack{
            TextField("テキストを入力", text: $viewModel.userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("送信") {
                if let location = locationManager.location {
                    print("入力されたテキスト: \(viewModel.userInput)")
                    print("現在地: 緯度 \(location.coordinate.latitude), 経度 \(location.coordinate.longitude)")
                } else {
                    print("位置情報が利用できません")
                }
                
                viewModel.userInput=""
                
                // ここで後ほど、AR空間にテキストを配置する処理を追加
            }
            .padding()
        }
        .onAppear{
            locationManager.requestPermission()
            locationManager.startUpdatingLocation()
        }
    }
}

struct TextBoxView_Previews: PreviewProvider {
    static var previews: some View {
        TextBoxView()
            .environmentObject(TextBoxViewModel())
    }
}
