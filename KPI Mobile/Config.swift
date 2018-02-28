//
//  Config.swift
//  KPI Mobile
//
//  Created by Maxim Mamuta on 2/27/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//
import Foundation

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
