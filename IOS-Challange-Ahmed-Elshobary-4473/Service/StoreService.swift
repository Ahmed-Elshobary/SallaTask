//
//  StoreService.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol StoreServiceProtocol {
    func fetchStoreDetails() async throws -> StoreDetails
}

class StoreService: StoreServiceProtocol {
    func fetchStoreDetails() async throws -> StoreDetails {
        guard let url = Bundle.main.url(forResource: "Developers", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let storeDetails = try decoder.decode(StoreDetails.self, from: data)
        return storeDetails
    }
}
