//
//  StoreDetailsRepository.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation
import Foundation

protocol StoreDetailsRepositoryProtocol {
    func fetchStoreDetails() async throws -> StoreDetails
}

class StoreDetailsRepository: StoreDetailsRepositoryProtocol {
    func fetchStoreDetails() async throws -> StoreDetails {
        // Similar to existing StoreService, but with a repository abstraction
        guard let url = Bundle.main.url(forResource: "Developers", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(StoreDetails.self, from: data)
    }
}
