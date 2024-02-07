//
//  TextView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/07.
//

import SwiftUI
import FirebaseFirestore

struct TextView: View {
    @EnvironmentObject var textviewModel: TextBoxViewModel
    @ObservedObject private var viewModel = UserViewModel()
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            
            TextField("Name", text: $textviewModel.userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("送信") {
                viewModel.saveUser(name: textviewModel.userInput) { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        print("User saved successfully.")
                    }
                }
                
                if let location = locationManager.location {
                    print("入力されたテキスト: \(textviewModel.userInput)")
                    print("現在地: 緯度 \(location.coordinate.latitude), 経度 \(location.coordinate.longitude)")
                } else {
                    print("位置情報が利用できません")
                }
                
                
                textviewModel.userInput=""
            }
        }
        .onAppear{
            locationManager.requestPermission()
            locationManager.startUpdatingLocation()
        }
    }
}

#Preview {
    TextView()
}
