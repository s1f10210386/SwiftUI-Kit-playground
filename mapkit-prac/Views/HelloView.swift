//
//  HelloView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

// ログイン後の画面
struct HelloView: View {
    var viewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("Hello, you're logged in!")
                .font(.title)
                .padding()
            Button("Log Out") {
                // ログアウトしてログイン画面へ遷移する
                viewModel.signOut()
            }
        }
    }
}

#Preview {
    HelloView(viewModel: AuthViewModel())
}
