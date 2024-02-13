//
//  SignInView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var viewModel: AuthViewModel
    
//    @State private var navigateToContentView = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Sign In") {
                    viewModel.signIn(email: email, password: password)
                    
                }

//                if viewModel.isAuthenticated {
//                    // ログイン後のページに遷移
//                    ContentView()
//                        .environmentObject(TextBoxViewModel())
//                }
//                
//                NavigationLink(destination: ContentView().environmentObject(TextBoxViewModel()), isActive: $navigateToContentView) { EmptyView() }
//                            }

                // 新規登録画面への遷移ボタン
                NavigationLink(destination: SignUpView(viewModel: viewModel)) {
                    Text("Create Account")
                        .padding(.top, 16)
                }
                // パスワードのリセットページへ移動する
                NavigationLink(destination: ResetPasswordView(viewModel: viewModel)) {
                    Text("Password Reset")
                        .padding(.top, 16)
                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: AuthViewModel())
}
