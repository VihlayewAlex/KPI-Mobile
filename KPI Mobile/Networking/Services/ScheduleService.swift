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
    
    func getGroupBy(limit: Int, offset: Int) {
        apiCommunicator.baseRequest(method: .GET, to: .groupsPagination(limit: limit, offset: offset), withCompletion: { (data, error) in
            if let error = error {
                print(error.localizedDescription) //TODO: make show error to user or handle it
                return
            } else if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode(Group.self, from: data)
                    print("🤠", decodeData.description)
                } catch {
                    print("👌👈", error.localizedDescription) //TODO: make show error to user or handle it
                }
            }
        })
    }
}
