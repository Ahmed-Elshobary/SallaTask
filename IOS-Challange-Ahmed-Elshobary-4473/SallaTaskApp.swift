//
//  SallaTaskApp.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

//@main
//struct SallaTaskApp: App {
//    let persistenceController = PersistenceController.shared
//    let networkManager = NetworkManager.shared
//
//    var body: some Scene {
//        WindowGroup {
//            BrandDetailView(
//                fetchStoreDetails: {
//                    do {
//                        return try await StoreDetailsUseCase(repository: StoreDetailsRepository()).execute()
//                    } catch {
//                        print("Error fetching store details: \(error)")
//                        return nil
//                    }
//                },
//                fetchProducts: { page, loadMore in  // Use 'page' (Int)
//                    do {
//                        let productResponse = try await ProductUseCase(repository: ProductRepository()).execute(storeId: "")
//                        return productResponse.data  // Return the array of ProductModel
//                    } catch {
//                        print("Error fetching products: \(error.localizedDescription)")
//                        return []  // Return an empty array in case of failure
//                    }
//                },
//                fetchThemeSettings: {
//                    do {
//                        try await ThemeSettingsUseCase(repository: ThemeRepository()).execute()
//                    } catch {
//                        print("Error fetching theme settings: \(error)")
//                    }
//                }
//            )
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

import SwiftUI

@main
struct SallaTaskApp: App {
    let persistenceController = PersistenceController.shared
    let networkManager = NetworkManager.shared

    var body: some Scene {
        WindowGroup {
            BrandDetailView(
                fetchStoreDetails: {
                    do {
                        return try await StoreDetailsUseCase(repository: StoreDetailsRepository()).execute()
                    } catch {
                        print("Error fetching store details: \(error)")
                        return nil
                    }
                },
                fetchProducts: { page in
                    do {
                        let productResponse = try await ProductUseCase(repository: ProductRepository()).execute(page: page)
                        return productResponse.data  // Return the array of ProductModel
                    } catch {
                        print("Error fetching products: \(error.localizedDescription)")
                        return []  // Return an empty array in case of failure
                    }
                },
                fetchThemeSettings: {
                    do {
                        try await ThemeSettingsUseCase(repository: ThemeRepository()).execute()
                    } catch {
                        print("Error fetching theme settings: \(error)")
                    }
                }
            )
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
