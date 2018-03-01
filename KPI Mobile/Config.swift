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
    case teacherPagination(limit: Int, offset: Int)
    case currentWeek()
    case groupScheduleByName(group: String)
    
    var url: String {
        switch self {
        case .groupsPagination(let limit, let offset):
            return "groups/?filter=\(getJsonPagination(limit: limit, offset: offset))"
        case .teacherPagination(let limit, let offset):
            return "teachers/?filter=\(getJsonPagination(limit: limit, offset: offset))"
        case .currentWeek():
            return "weeks"
        case .groupScheduleByName(let group):
            return "groups/\(group)/lessons".urlEncoding()
        }
    }
    
    func getJsonPagination(limit: Int, offset: Int) -> String {
        return "{\"limit\":\(limit),\"offset\":\(offset)}".urlEncoding()
    }
}

extension String {
    func urlEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}
