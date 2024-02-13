//
//  Second.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI
import MapKit


struct Second: View {
    @EnvironmentObject var viewModel: TextBoxViewModel
    @Binding var route: MKRoute?
    
    
    var body: some View {
        VStack {
            Text("Second View")
            Button(action: {
            
            }) {
                Text("Call Coordinate")
            }
        }
        Text("入力されたテキスト: \(viewModel.userInput)")
    }
}

