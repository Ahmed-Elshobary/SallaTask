//
//  ProductDetailUseCase.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol ProductDetailUseCaseProtocol {
    func execute(productId: String) async throws -> ProductDetailModel?
}

class ProductDetailUseCase: ProductDetailUseCaseProtocol {
    private let repository: ProductDetailRepositoryProtocol  // Injected repository for data access

    init(repository: ProductDetailRepositoryProtocol) {
        self.repository = repository
    }

    func execute(productId: String) async throws -> ProductDetailModel? {
        return try await repository.fetchProductDetails(productId: productId)
    }
}
