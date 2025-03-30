//
//  ProductModel.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation


struct ProductModel: Identifiable, Codable {
    let id: String  // Ensure this is unique
    let name: String
    let description: String?
    let image: ProductImage?
    let price: Double
    let currency: String
    
    struct ProductImage: Codable {
        let url: String?
    }
}
struct ProductResponse: Codable {
    let data: [ProductModel]
    let cursor: Cursor?

    struct Cursor: Codable {
        let current: String
        let next: String?  // If next is null, we have reached the last page
    }
}

struct ProductDetailModelResponse: Codable {
    let data: ProductDetailModel
}

struct ProductDetailModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let price: Double?
    let image: ProductImage?

}

struct ProductImage: Codable {
    let url: String?
    let alt: String?
}
