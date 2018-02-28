//
//  ApiCommunicator.swift
//  KPI Mobile
//
//  Created by Alex Vihlayew on 2/27/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//

import Foundation

struct Server {
    let scheme: String
    let domain: String
    let apiVersion: Int
}

extension Server {
    var apiRoute: String {
        return "\(scheme)://\(domain)/v\(apiVersion)/"
    }
}

struct ApiCommunicator {
    
    enum ApiCommunicatorError: Error, LocalizedError {
        case invalidEndpoint(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidEndpoint(let endpointString):
                return "Invalid endpoint: " + endpointString
            }
        }
    }
    
    enum HttpMethod: String {
        case POST
        case GET
    }
    
    let server: Server
    
    init(server: Server) {
        self.server = server
    }
    
    func baseRequest(method: HttpMethod, to route: Route, withCompletion completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: server.apiRoute + route.url) else {
            completion(nil, ApiCommunicatorError.invalidEndpoint(server.apiRoute + route.url))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    func baseRequest<T: Encodable>(method: HttpMethod, to route: Route, with data: T, withCompletion completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: server.apiRoute + route.url) else {
            completion(nil, ApiCommunicatorError.invalidEndpoint(server.apiRoute + route.url))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoder = JSONEncoder()
        do {
            let json = try encoder.encode(data)
            urlRequest.httpBody = json
        } catch {
            completion(nil, error)
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
}
