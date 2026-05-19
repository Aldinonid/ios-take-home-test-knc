//
//  NetworkService.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/19.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError
    case timeout
}

protocol NetworkService {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T
}

final class URLSessionNetworkService: NetworkService {
    
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw NetworkError.serverError
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
}
