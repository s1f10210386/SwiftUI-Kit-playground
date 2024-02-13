//
//  mapkit_pracApp.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/05.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct mapkit_pracApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var viewModel = AuthViewModel()
    @StateObject var locationViewModel = LocationViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            
            if viewModel.isAuthenticated {
                ContentView()
                    .environmentObject(TextBoxViewModel())
                    .environmentObject(locationViewModel)
            } else {
                //ログインじゃないなら
                SignInView(viewModel: viewModel)
            }
        }
    }
}
