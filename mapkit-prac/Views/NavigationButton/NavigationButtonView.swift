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
    @State private var isShowWarning = false
    
    
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                isShowWarning = true
                isShowARView = true
            }) {
                Image(systemName: "cube.transparent")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue.opacity(0.7))
                    .clipShape(Circle())
            }
            .fullScreenCover(isPresented: $isShowWarning) {
                WarningView(isPresented: $isShowWarning)
            }
            .fullScreenCover(isPresented: $isShowARView) {
                FullScreenARView()
            }
            
            Button(action: {
                isShowSecond = true
            }) {
                Image(systemName: "gearshape.fill")
                    .padding()
                    .foregroundColor(.white)
                    .sheet(isPresented: $isShowSecond){
                        TestView()
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
                        ObjectARContentView()
                        //                        HelloView(viewModel: AuthViewModel())
                            .presentationDetents([.medium, .large])
                    }
                    .background(Color.blue.opacity(0.7))
                    .clipShape(Circle())
            }
        }
        
        .padding(.trailing, 20) // 画面の右側に余白を追加
        
    }
    
    
}





