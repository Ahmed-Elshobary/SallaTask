//
//  ProductDetailRepositoryTests.swift
//  SallaTaskTests
//
//  Created by ahmed elshobary on 08/09/2024.
//

import XCTest
@testable import SallaTask

class ProductDetailRepositoryTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var productDetailRepository: ProductDetailRepository!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        productDetailRepository = ProductDetailRepository(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        productDetailRepository = nil
        super.tearDown()
    }
    
    // Test case for successful product detail fetching
    func testFetchProductDetailsSuccess() async throws {
        // Arrange
        let mockProductDetail = ProductDetailModel(
            id: 1,
            name: "Product Detail",
            description: "Description",
            price: 100.0,
            image: ProductImage(url: "https://example.com/image.png", alt: "Image Alt")
        )

        let mockProductDetailResponse = ProductDetailModelResponse(data: mockProductDetail)
        mockNetworkManager.mockData = try! JSONEncoder().encode(mockProductDetailResponse)
        
        // Act
        let productDetail = try await productDetailRepository.fetchProductDetails(productId: "1")
        
        // Assert
        XCTAssertEqual(productDetail.name, "Product Detail")
        XCTAssertEqual(productDetail.price, 100.0)
        XCTAssertEqual(productDetail.image?.url, "https://example.com/image.png")
    }
    
    // Test case for failure during product detail fetching
    func testFetchProductDetailsFailure() async {
        // Arrange
        mockNetworkManager.error = NetworkError.invalidResponse
        
        // Act & Assert
        do {
            _ = try await productDetailRepository.fetchProductDetails(productId: "1")
            XCTFail("Expected error to be thrown, but it wasn't.")
        } catch let error as NetworkError {
            // Assert that the correct error was thrown
            XCTAssertEqual(error, NetworkError.invalidResponse)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
