//
//  ThemeRepository.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol ThemeRepositoryProtocol {
    func fetchThemeSettings() async throws -> ThemeResponse
}

class ThemeRepository: ThemeRepositoryProtocol {
    func fetchThemeSettings() async throws -> ThemeResponse {
        guard let themeURL = Bundle.main.url(forResource: "Developers", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try await fetchData(from: themeURL)
        let decoder = JSONDecoder()
        return try decoder.decode(ThemeResponse.self, from: data)
    }

    // A helper function to fetch data asynchronously
    private func fetchData(from url: URL) async throws -> Data {
        return try Data(contentsOf: url)
    }
}
