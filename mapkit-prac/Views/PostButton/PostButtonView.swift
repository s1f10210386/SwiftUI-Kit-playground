//
//  PostButtonView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

struct PostButtonView: View {
    
    @State var isShowMessageView = false
    
    var body: some View {
        
        Button(action:{
            isShowMessageView = true
        }){
            Image(systemName:"plus.message")
                .padding()
                .sheet(isPresented: $isShowMessageView){
                    TextView()
                        .presentationDetents([.medium, .large])
                        
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
        }
    }
}

#Preview {
    PostButtonView()
}


