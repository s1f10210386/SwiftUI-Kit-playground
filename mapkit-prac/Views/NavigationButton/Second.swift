//
//  Second.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/06.
//

import SwiftUI

struct Second: View {
    @EnvironmentObject var viewModel: TextBoxViewModel
    
    var body: some View {
        Text("入力されたテキスト: \(viewModel.userInput)")
    }
}

