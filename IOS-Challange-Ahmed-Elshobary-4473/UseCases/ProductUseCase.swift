//
//  ProductUseCase.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol ProductUseCaseProtocol {
    func execute(page: Int) async throws -> ProductResponse
}

class ProductUseCase: ProductUseCaseProtocol {
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> ProductResponse {
        return try await repository.fetchProducts(page: page)
    }
}

