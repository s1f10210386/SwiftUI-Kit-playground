//
//  FullScreenARView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/13.
//

import SwiftUI

struct FullScreenARView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ARViewModel()

    var body: some View {
        VStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
//            Button("Switch to Indoor Mode") {
//                viewModel.startARSession()
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            
            // 閉じるボタン
            Button(action: {
                // ビューを閉じる
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            }
            .padding() // 必要に応じて調整
            .accessibilityLabel(Text("閉じる"))
        }
    }
}

#Preview {
    FullScreenARView()
}
