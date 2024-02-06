//
//  NavigationView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        VStack {
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
        
        .padding(.trailing, 20) // 画面の右側に余白を追加
        
    }
}


#Preview {
    NavigationView()
}
