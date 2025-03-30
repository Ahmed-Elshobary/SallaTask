//
//  StoreDetailsUseCase.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol StoreDetailsUseCaseProtocol {
    func execute() async throws -> StoreDetails
}

class StoreDetailsUseCase: StoreDetailsUseCaseProtocol {
    private let repository: StoreDetailsRepositoryProtocol
    
    init(repository: StoreDetailsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> StoreDetails {
        return try await repository.fetchStoreDetails()
    }
}
