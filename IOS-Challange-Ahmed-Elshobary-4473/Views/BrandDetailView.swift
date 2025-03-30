//
//  ContentView.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import SwiftUI

struct BrandDetailView: View {
    let fetchStoreDetails: () async -> StoreDetails?
    let fetchProducts: (Int) async -> [ProductModel]
    let fetchThemeSettings: () async -> Void

    @ObservedObject var themeManager = ThemeManager.shared
    @State private var storeDetails: StoreDetails? = nil
    @State private var products: [ProductModel] = []  // The product list
    @State private var currentPage = 1                // Track the current page for pagination
    @State private var isLoadingMore = false          // Track whether more items are being loaded
    @State private var isLastPage = false             // Track whether we've hit the last page
    @State private var isLoading = true               // Initial loading state

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Store details at the top
                    if let storeDetails = storeDetails {
                        Text(storeDetails.store)
                            .font(.custom(themeManager.fontFamily, size: 18))
                            .foregroundColor(.black)
                            .padding(.top, 16)
                    } else {
                        ProgressView("Loading store details...")
                            .padding(.top, 16)
                    }

                    // Product grid
                    if !products.isEmpty {
//                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
//                            ForEach(Array(products.enumerated()), id: \.offset) { index, product in
//                                ProductCell(product: product)
//                                    .onAppear {
//                                        // Trigger loading more products when the last item appears
//                                        if index == products.count - 1 && !isLastPage && !isLoadingMore {
//                                            Task {
//                                                await loadMoreProducts()
//                                            }
//                                        }
//                                    }
//                            }
//                        }
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(Array(products.enumerated()), id: \.offset) { index, product in
                                NavigationLink(
                                    destination: ProductDetailView(productId: product.id, viewModel: ProductDetailViewModel(productDetailUseCase: ProductDetailUseCase(repository: ProductDetailRepository()))),
                                    label: {
                                        ProductCell(product: product)
                                    }
                                )
                                .onAppear {
                                    // Trigger loading more products when the last item appears
                                    if index == products.count - 1 && !isLastPage && !isLoadingMore {
                                        Task {
                                            await loadMoreProducts()
                                        }
                                    }
                                }
                            }
                        }


                        .padding()

                        // Show a loader when loading more products
                        if isLoadingMore {
                            ProgressView("Loading more products...")
                                .padding()
                        }
                    } else if !isLoading {
                        // No products found case
                        Text("No products found.")
                            .foregroundColor(.gray)
                            .padding()
                    }

                    // Initial loader
                    if isLoading {
                        ProgressView("Loading products...")
                            .padding()
                    }
                }
            }
            .navigationTitle("Brand Details")
            .background(themeManager.appColor)
            .onAppear {
                Task {
                    await loadInitialData()
                }
            }
        }
    }

    // Initial data load: fetch store details, products, and theme settings
    private func loadInitialData() async {
        isLoading = true
        await fetchThemeSettings()  // Fetch theme settings

        storeDetails = await fetchStoreDetails()  // Fetch store details

        // Load the first page of products
        let firstPageProducts = await fetchProducts(currentPage)
        products = firstPageProducts

        if firstPageProducts.isEmpty {
            isLastPage = true  // No more pages to load
        }

        isLoading = false
    }

    // Function to load more products when scrolling to the end of the list
    private func loadMoreProducts() async {
        guard !isLastPage else {
            print("Reached last page, no more products to load.")
            return
        }

        isLoadingMore = true
        currentPage += 1  // Increment the page number

        print("Fetching page \(currentPage)...")

        let newProducts = await fetchProducts(currentPage)

        if !newProducts.isEmpty {
            print("Fetched \(newProducts.count) new products")
            products.append(contentsOf: newProducts)
        } else {
            print("No more products to load, marking as last page.")
            isLastPage = true  // If no more products, mark as the last page
        }

        isLoadingMore = false
    }

}
