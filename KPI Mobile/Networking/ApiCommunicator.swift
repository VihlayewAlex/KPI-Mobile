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
    
    enum ApiCommunicatorError: Error {
        case invalidEndpoint
    }
    
    enum Route {
        case groupsPagination(limit: Int, offset: Int)
        case groupByName(name: String)
        
        var url: String {
            switch self {
                case .groupsPagination(let limit, let offset):
                    return "groups/?filter={\"limit\":\(limit),\"offset\":\(offset)}"
                case .groupByName(let name):
                    return "groups/" + name
            }
        }
    }
    
    let server: Server
    
    init(server: Server) {
        self.server = server
    }
    
    func basePostRequest(to route: Route, withCompletion completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: server.apiRoute + route.url) else {
            completion(nil, ApiCommunicatorError.invalidEndpoint)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
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
    
    func basePostRequest<T: Encodable>(to route: Route, with data: T, withCompletion completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: server.apiRoute + route.url) else {
            completion(nil, ApiCommunicatorError.invalidEndpoint)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
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
