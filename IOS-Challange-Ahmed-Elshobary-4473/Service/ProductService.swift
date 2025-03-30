//
//  ProductService.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//


import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(pageNumber: Int, storeID: String) async throws -> ProductResponse
    func fetchProductDetails(productId: String, storeID: String) async throws -> ProductDetailModelResponse
}


class ProductService: ProductServiceProtocol {
    private let networkManager: NetworkService
    
    // Inject NetworkManager using Dependency Injection
    init(networkManager: NetworkService = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // Fetch products with dynamic page number
    func fetchProducts(pageNumber: Int, storeID: String) async throws -> ProductResponse {
        let urlString = "https://api.salla.dev/store/v1/brands/1724782240?page=\(pageNumber)&per_page=5"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        return try await networkManager.fetchData(url: url, storeID: storeID, decodingType: ProductResponse.self)
    }
    
    func fetchProductDetails(productId: String, storeID: String) async throws -> ProductDetailModelResponse {
        let urlString = "https://api.salla.dev/store/v1/products/\(productId)/details"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        return try await networkManager.fetchData(url: url, storeID: storeID, decodingType: ProductDetailModelResponse.self)
    }
}
