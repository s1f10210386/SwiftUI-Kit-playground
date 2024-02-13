//
//  FullScreenARView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/13.
//

import SwiftUI

struct FullScreenARView: View {
    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var locationViewModel: LocationViewModel
    var coordinator = Coordinator(locationViewModel: LocationViewModel())

    var body: some View {
        VStack {
            // ここにARViewContainerを配置
            ARViewContainer(locationViewModel: LocationViewModel())
                .edgesIgnoringSafeArea(.all) // フルスクリーン表示をする場合、Safe Areaを無視する
                .environmentObject(coordinator)

            Button("Place Navigation Points") {
                coordinator.userDidTapButton()
            }
            
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
