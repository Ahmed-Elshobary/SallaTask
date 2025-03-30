//
//  ProductRepositoryTests.swift
//  SallaTaskTests
//
//  Created by ahmed elshobary on 08/09/2024.
//

import XCTest
@testable import SallaTask

class MockNetworkManager: NetworkService {
    var mockData: Data?
    var error: NetworkError?

    func fetchData<T>(url: URL, decodingType: T.Type) async throws -> T where T : Codable {
        if let error = error {
            throw error
        }
        guard let mockData = mockData else {
            throw NetworkError.invalidResponse
        }
        let decodedData = try JSONDecoder().decode(decodingType, from: mockData)
        return decodedData
    }
}

class ProductRepositoryTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var productRepository: ProductRepository!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        productRepository = ProductRepository(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        productRepository = nil
        super.tearDown()
    }
    
    func testFetchProductsSuccess() async throws {
        // Arrange
        let mockProductResponse = ProductResponse(
            data: [
                ProductModel(id: "1", name: "Product 1", description: nil, image: nil, price: 10.0, currency: "SAR"),
                ProductModel(id: "2", name: "Product 2", description: nil, image: nil, price: 15.0, currency: "SAR")
            ],
            cursor: nil
        )
        mockNetworkManager.mockData = try! JSONEncoder().encode(mockProductResponse)
        
        // Act
        let response = try await productRepository.fetchProducts(page: 1)
        
        // Assert
        XCTAssertEqual(response.data.count, 2)
        XCTAssertEqual(response.data[0].name, "Product 1")
        XCTAssertEqual(response.data[1].name, "Product 2")
    }
    
    func testFetchProductsFailure() async {
        // Arrange
        mockNetworkManager.error = NetworkError.invalidURL
        
        // Act & Assert
        do {
            _ = try await productRepository.fetchProducts(page: 1)
            XCTFail("Expected error to be thrown, but it wasn't.")
        } catch let error as NetworkError {
            // Assert that the correct error was thrown
            XCTAssertEqual(error, NetworkError.invalidURL)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

}

// Helper function for async XCTAssertThrowsError
extension XCTestCase {
    func XCTAssertThrowsErrorAsync<T>(_ expression: @autoclosure () async throws -> T,
                                      _ message: @autoclosure () -> String = "",
                                      file: StaticString = #file, line: UInt = #line,
                                      errorHandler: (Error) -> Void) async {
        do {
            _ = try await expression()
            XCTFail("Expected error to be thrown - \(message())", file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
