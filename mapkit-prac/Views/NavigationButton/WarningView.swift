//
//  WarningView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/16.
//

import SwiftUI

struct WarningView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
       
        ZStack {
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            
            // コンテンツのコンテナ
            VStack(spacing: 15) {
                Text("ARモードについて")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("スマートフォンの画面を注視しながらの歩行は大変危険です。周囲の状況をよくみて、安全なご利用に充分ご留意ください。")
                    .foregroundColor(.white)
                    .padding()
                
                Button("了解しました") {
                    isPresented = false
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.gray.opacity(0.8))
            .cornerRadius(15)
        }
    }
}

