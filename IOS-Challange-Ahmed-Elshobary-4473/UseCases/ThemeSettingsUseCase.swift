//
//  ThemeSettingsUseCase.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol ThemeSettingsUseCaseProtocol {
    func execute() async throws
}

class ThemeSettingsUseCase: ThemeSettingsUseCaseProtocol {
    private let repository: ThemeRepositoryProtocol
    
    init(repository: ThemeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws {
        do {
            let themeResponse = try await repository.fetchThemeSettings()
            
            // Update the ThemeManager with the fetched settings
            await MainActor.run {
                ThemeManager.shared.updateTheme(appColor: themeResponse.appColor, fontFamily: themeResponse.fontFamily, storeId: themeResponse.id)
            }
        } catch {
            print("Error fetching theme settings: \(error)")
        }
    }
}
