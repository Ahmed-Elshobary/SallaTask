//
//  StoreDetailsViewModel.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

class StoreDetailsViewModel: ObservableObject {
    @Published var storeDetails: StoreDetails?
    @Published var error: Error?

    private let storeService: StoreServiceProtocol

    // Inject StoreService using Dependency Injection
    init(storeService: StoreServiceProtocol) {
        self.storeService = storeService
    }

    @MainActor
    func fetchStoreDetails() async {
        do {
            let storeDetails = try await storeService.fetchStoreDetails()
            self.storeDetails = storeDetails
        } catch {
            self.error = error
        }
    }
}
