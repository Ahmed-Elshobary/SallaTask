//
//  Color+Extention.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation
import SwiftUI

extension Color {
    /// Initialize SwiftUI `Color` from ARGB (hex) value
    init(argb: UInt) {
        let alpha = Double((argb >> 24) & 0xFF) / 255.0
        let red = Double((argb >> 16) & 0xFF) / 255.0
        let green = Double((argb >> 8) & 0xFF) / 255.0
        let blue = Double(argb & 0xFF) / 255.0

        print("Converted ARGB to RGBA: R:\(red), G:\(green), B:\(blue), A:\(alpha)")  // Debugging print statement
        
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
