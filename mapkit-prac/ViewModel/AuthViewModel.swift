//
//  AuthViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI
import Firebase


class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    // イニシャライザメソッドを呼び出して、アプリの起動時に認証状態をチェックする
    init() {
            observeAuthChanges()
        }

        private func observeAuthChanges() {
            Auth.auth().addStateDidChangeListener { [weak self] _, user in
                DispatchQueue.main.async {
                    self?.isAuthenticated = user != nil
                }
            }
        }
    // ログインするメソッド
    func signIn(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                DispatchQueue.main.async {
                    if result != nil, error == nil {
                        self?.isAuthenticated = true
                    }
                }
            }
        }
    // 新規登録するメソッド
//    func signUp(email: String, password: String) {
//        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
//            DispatchQueue.main.async {
//                if result != nil, error == nil {
//                    self?.isAuthenticated = true
//                }
//            }
//        }
//    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let user = result?.user, error == nil {
                    self?.isAuthenticated = true
                    
                    // Firestoreにユーザー情報を保存
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "id": user.uid,
                        "email": email,
                        "createdAt": Timestamp(date: Date())
                    ]) { error in
                        if let error = error {
                            print("Error saving user to Firestore: \(error)")
                        } else {
                            print("User successfully saved to Firestore with UID: \(user.uid)")
                        }
                    }
                    
                } else if let error = error {
                    print("Error creating user: \(error.localizedDescription)")
                }
            }
        }
    }

    // パスワードをリセットするメソッド
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error in sending password reset: \(error)")
            }
        }
    }
    // ログアウトするメソッド
    func signOut() {
            do {
                try Auth.auth().signOut()
                isAuthenticated = false
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
}
