//
//  ProductDetailViewModel.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductDetailModel?
    @Published var isLoading = true
    @Published var hasError = false
    @Published var errorMessage: String?

    private let productDetailUseCase: ProductDetailUseCaseProtocol

    init(productDetailUseCase: ProductDetailUseCaseProtocol) {
        self.productDetailUseCase = productDetailUseCase
    }

    @MainActor
    func fetchProductDetails(productId: String) async {
        isLoading = true
        hasError = false
        errorMessage = nil

        do {
            let fetchedProduct = try await productDetailUseCase.execute(productId: productId)
            self.product = fetchedProduct
        } catch {
            hasError = true
            errorMessage = "Failed to fetch product details: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
