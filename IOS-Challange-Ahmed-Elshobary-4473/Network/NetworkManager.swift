//
//  NetworkManager.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation

protocol NetworkService {
    func fetchData<T: Codable>(url: URL, storeID: String ,decodingType: T.Type) async throws -> T
}

class NetworkManager: NetworkService {
    static let shared = NetworkManager()
    
    private let cache = URLCache(memoryCapacity: 50_000_000, diskCapacity: 100_000_000, diskPath: "urlCache")

    func fetchData<T: Codable>(url: URL, storeID: String,decodingType: T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("SAR", forHTTPHeaderField: "Currency")
        request.addValue("3.0.0", forHTTPHeaderField: "AppVersion")
        request.addValue(storeID, forHTTPHeaderField: "Store-Identifier")
        
        if let cachedResponse = cache.cachedResponse(for: request) {
            return try JSONDecoder().decode(T.self, from: cachedResponse.data)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)

        return try JSONDecoder().decode(T.self, from: data)
    }
}

