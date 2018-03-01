//
//  Group.swift
//  KPI Mobile
//
//  Created by Maxim Mamuta on 2/27/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//

struct Group: Decodable {
    let id: Int?
    let fullName: String
    let prefix: String
    let okr: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "group_id"
        case fullName = "group_full_name"
        case prefix = "group_prefix"
        case okr = "group_okr"
        case type = "group_type"
    }
}

extension Group: CustomStringConvertible {
    var description: String {
        return "[\(id) \(fullName) \(prefix) \(okr) \(type)]"
    }
}
