//
//  StoreModel.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation
struct StoreDetails: Codable, Equatable {
    let id: Int
    let store: String
    let appColor: UInt
    let fontFamily: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case store
        case appColor = "app_color"  // Custom mapping for snake_case in JSON
        case fontFamily = "font_family"  // Custom mapping for snake_case in JSON
    }
}
