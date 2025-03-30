//
//  ThemeViewModel.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation
import SwiftUI
import Combine

//class ThemeViewModel: ObservableObject {
//    private var cancellables = Set<AnyCancellable>()
//
//    func fetchThemeSettings() {
//        let themeURL = Bundle.main.url(forResource: "Developers", withExtension: "json")!
//
//        do {
//            let data = try Data(contentsOf: themeURL)
//            let decoder = JSONDecoder()
//            let themeResponse = try decoder.decode(ThemeResponse.self, from: data)
//            
//            // Update the ThemeManager with values from the JSON
//            print("Fetched app_color: \(themeResponse.appColor)")  // Debugging print statement
//            ThemeManager.shared.updateTheme(appColor: themeResponse.appColor, fontFamily: themeResponse.fontFamily)
//        } catch {
//            print("Failed to load theme settings: \(error)")
//        }
//    }
//}


class ThemeViewModel: ObservableObject {
    func fetchThemeSettings() async {
        do {
            guard let themeURL = Bundle.main.url(forResource: "Developers", withExtension: "json") else {
                print("JSON file not found in bundle!")
                throw URLError(.fileDoesNotExist)
            }

            let data = try await fetchData(from: themeURL)
            let decoder = JSONDecoder()
            let themeResponse = try decoder.decode(ThemeResponse.self, from: data)
            
            // Log the response for debugging
            print("Decoded themeResponse: \(themeResponse)")

            await MainActor.run {
                ThemeManager.shared.updateTheme(appColor: themeResponse.appColor, fontFamily: themeResponse.fontFamily, storeId: themeResponse.id)
                print("Theme updated with color: \(themeResponse.appColor), font: \(themeResponse.fontFamily), storeId: \(themeResponse.id)")
            }
        } catch {
            print("Failed to load theme settings: \(error.localizedDescription)")
        }
    }

    private func fetchData(from url: URL) async throws -> Data {
        return try Data(contentsOf: url)
    }
}


struct ThemeResponse: Codable {
    let id: Int
    let store: String
    let appColor: UInt
    let fontFamily: String

    // Custom CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case store
        case appColor = "app_color"  // Map "app_color" in JSON to "appColor" in Swift
        case fontFamily = "font_family"  // Map "font_family" in JSON to "fontFamily"
    }
}
