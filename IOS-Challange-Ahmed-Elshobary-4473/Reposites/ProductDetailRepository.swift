//
//  ProductDetailRepository.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol ProductDetailRepositoryProtocol {
    func fetchProductDetails(productId: String) async throws -> ProductDetailModel
}

class ProductDetailRepository: ProductDetailRepositoryProtocol {
    private let networkManager: NetworkService

    init(networkManager: NetworkService = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchProductDetails(productId: String) async throws -> ProductDetailModel {
        let urlString = "https://api.salla.dev/store/v1/products/\(productId)/details"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        return try await networkManager.fetchData(url: url, storeID: ThemeManager.shared.storeId, decodingType: ProductDetailModelResponse.self).data
    }
}
