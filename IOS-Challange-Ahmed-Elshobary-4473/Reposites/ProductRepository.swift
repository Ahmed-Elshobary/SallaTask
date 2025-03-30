//
//  ProductRepository.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//


import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts(page: Int) async throws -> ProductResponse
}

class ProductRepository: ProductRepositoryProtocol {
    private let networkManager: NetworkService

    init(networkManager: NetworkService = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchProducts(page: Int) async throws -> ProductResponse {
        let urlString = "https://api.salla.dev/store/v1/brands/1724782240?page=\(page)&per_page=5"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NetworkError.invalidURL
        }

        print("Requesting URL: \(urlString)")

        return try await networkManager.fetchData(url: url, storeID: ThemeManager.shared.storeId, decodingType: ProductResponse.self)
    }

}
