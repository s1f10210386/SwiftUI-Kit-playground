//
//  MessageView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

struct MessageView: View {
    @State private var userInput: String = ""
    
    @ObservedObject var locationManager = LocationManager()

    
    var body: some View {
        VStack{
            TextField("テキストを入力", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("送信") {
                if let location = locationManager.location {
                    print("入力されたテキスト: \(userInput)")
                    print("現在地: 緯度 \(location.coordinate.latitude), 経度 \(location.coordinate.longitude)")
                } else {
                    print("位置情報が利用できません")
                }
                
                userInput = ""
                
                // ここで後ほど、AR空間にテキストを配置する処理を追加
            }
            .padding()
        }
    }
}

#Preview {
    MessageView()
}
