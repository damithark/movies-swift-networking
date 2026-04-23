//
//  APIError.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-23.
//


import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL: 
                return "The URL is invalid"
            case .invalidResponse: 
                return "Invalid response from the server"
            case .decoding(let error): 
                return "Failed to decode response: \(error.localizedDescription)"
            case .networkError(let error): 
                return "Network error: \(error.localizedDescription)"
        }
    }
}
