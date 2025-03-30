//
//  ProductViewModel.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var error: NetworkError?
    
    private let productService: ProductServiceProtocol
    
    // Inject ProductService using Dependency Injection
    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    @MainActor
    func fetchProducts(page: Int) async {
        do {
            let productResponse = try await productService.fetchProducts(pageNumber: page, storeID: ThemeManager.shared.storeId)
            self.products = productResponse.data
        } catch let networkError as NetworkError {
            self.error = networkError
        } catch {
            self.error = .unknownError(error)
        }
    }
}

