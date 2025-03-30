//
//  NetworkError.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case unknownError(Error)
    case statusCodeError(Int)
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.statusCodeError(let code1), .statusCodeError(let code2)):
            return code1 == code2
        case (.decodingError, .decodingError):
            return true
        case (.unknownError, .unknownError):
            return true
        default:
            return false
        }
    }
}
