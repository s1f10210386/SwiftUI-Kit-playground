//
//  TextBoxViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/07.
//

import SwiftUI

import Combine

class TextBoxViewModel: ObservableObject {
    @Published var userInput: String = ""
}
