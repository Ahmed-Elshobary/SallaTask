//
//  BrandDetailView.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel
    @ObservedObject var themeManager = ThemeManager.shared  // Access the themeManager instance

    let productId: String

    // Initialize with product ID and view model
    init(productId: String, viewModel: ProductDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.productId = productId
    }

    var body: some View {
        ScrollView {
            // Loading state
            if viewModel.isLoading {
                ProgressView("Loading product details...")
                    .padding()
            }
            // Error state
            else if viewModel.hasError {
                Text("Failed to load product details: \(viewModel.errorMessage ?? "Unknown error")")
                    .foregroundColor(.black)  // Use theme color for the error text
                    .padding()
            }
            // Success state
            else if let product = viewModel.product {
                VStack(alignment: .leading, spacing: 16) {
                    // Display product image
                    ProductImageView(imageUrl: product.image?.url ?? "", alt: product.image?.alt)

                    // Display product name with dynamic color
                    Text(product.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)  // Use theme color
                        .padding(.horizontal, 16)

                    // Display product description
                    if let description = product.description, !description.isEmpty {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                    }

                    // Display product price with dynamic color
                    Text("SAR \(product.price ?? 0, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.black)  // Use theme color
                        .padding(.horizontal, 16)

                    // Add to Cart Button with dynamic background color
                    Button(action: {
                        // Handle Add to Cart action
                    }) {
                        Text("أضف للسلة")
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(.black)  // Use theme color for button background
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                    }

                    // Add more product details here if necessary...
                }
            }
        }
        .navigationTitle("Product Details")
        .background(themeManager.appColor)
        .onAppear {
            Task {
                await viewModel.fetchProductDetails(productId: productId)
            }
        }
    }
}
