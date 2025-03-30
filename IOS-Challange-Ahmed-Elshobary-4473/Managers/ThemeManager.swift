//
//  ThemeManager.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    @Published var appColor: Color = .black  // Default color
    @Published var fontFamily: String = "System"  // Default font
    @Published var storeId: String = ""

    // Function to update the theme based on the API response
    func updateTheme(appColor: UInt, fontFamily: String, storeId: Int) {
        print("Setting app color to ARGB: \(appColor)")  // Debugging print statement
        self.appColor = Color(argb: appColor)  // Convert ARGB color
        self.fontFamily = fontFamily
        self.storeId = String(storeId)
    }
}
