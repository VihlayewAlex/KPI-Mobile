//
//  ScheduleService.swift
//  KPI Mobile
//
//  Created by Maxim Mamuta on 2/27/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//
import Foundation

class ScheduleService {
    let apiCommunicator : ApiCommunicator
    
    init(server: Server) {
        apiCommunicator = ApiCommunicator(server: server)
    }
    
    func getManyElementsBy<T: Decodable>(route: Route, elementType: T.Type) { //TODO: add response action
        apiCommunicator.baseRequest(method: .GET, to: route, withCompletion: { (data, error) in
            if let error = error {
                print(error.localizedDescription) //TODO: make show error to user or handle it
                return
            } else if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode(ResponseMany<T>.self, from: data)
                    print("🤠", decodeData.data.description)
                } catch {
                    print("👌👈", error.localizedDescription) //TODO: make show error to user or handle it
                }
            } else {
                print("👌👈", "No such response method")
            }
        })
    }
    
    func getOneElementBy<T: Decodable>(route: Route, elementType: T.Type) { //TODO: add response action
        apiCommunicator.baseRequest(method: .GET, to: route, withCompletion: { (data, error) in
            if let error = error {
                print(error.localizedDescription) //TODO: make show error to user or handle it
                return
            } else if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode(ResponseOne<T>.self, from: data)
                    print("🤠", decodeData.data)
                } catch {
                    print("👌👈", error.localizedDescription) //TODO: make show error to user or handle it
                }
            } else {
                print("👌👈", "No such response method")
            }
        })
    }
}
