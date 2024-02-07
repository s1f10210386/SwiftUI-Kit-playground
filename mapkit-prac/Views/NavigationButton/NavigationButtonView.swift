//
//  NavigationView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

struct NavigationButtonView: View {
    
    @State var isShowARView = false
    @State var isShowSecond = false
    @State var isShowThird = false
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                            isShowARView = true
                        }) {
                            Image(systemName: "cube.transparent")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .fullScreenCover(isPresented: $isShowARView) {
                            FullScreenARView()                        }
            
            Button(action: {
                isShowSecond = true
            }) {
                Image(systemName: "gearshape.fill")
                    .padding()
                    .foregroundColor(.white)
                    .sheet(isPresented: $isShowSecond){
                        Second()
                            .presentationDetents([.medium, .large])
                    }
                    .background(Color.blue.opacity(0.7))
                    .clipShape(Circle())
            }
            
            Button(action: {
                isShowThird = true
            }) {
                Image(systemName: "person.crop.circle.fill")
                    .padding()
                    .foregroundColor(.white)
                    .sheet(isPresented: $isShowThird){
                        Third()
                            .presentationDetents([.medium, .large])
                    }
                    .background(Color.blue.opacity(0.7))
                    .clipShape(Circle())
            }
        }
        
        .padding(.trailing, 20) // 画面の右側に余白を追加
        
    }
}




#Preview {
    NavigationButtonView()
}
