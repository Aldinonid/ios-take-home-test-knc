//
//  APIEndpoint.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

enum TaskEndpoint: APIEndpoint {
    case tasks
    
    var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .tasks:
            "/todos"
        }
    }
    
    var method: HTTPMethod { .get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
