//
//  Teacher.swift
//  KPI Mobile
//
//  Created by Maxim Mamuta on 2/28/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//

struct Teacher: Codable {
    let id : Int?
    let name : String?
    let fullName : String?
    let shortName : String?
    let rating : Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "teacher_id"
        case name = "teacher_name"
        case fullName = "teacher_full_name"
        case shortName = "teacher_short_name"
        case rating = "teacher_rating"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard let ids = try Int(values.decode(String.self, forKey: .id)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.id], debugDescription: "Expecting string representation of Int"))
        }
        id = ids
        name = try values.decodeIfPresent(String.self, forKey: .name)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        shortName = try values.decodeIfPresent(String.self, forKey: .shortName)
        guard let ratings = try Double(values.decode(String.self, forKey: .rating)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.rating], debugDescription: "Expecting string representation of Double"))
        }
        rating = ratings
    }
}

extension Teacher: CustomStringConvertible {
    var description: String {
        return "[\(id ?? -1) \(name ?? "Unknown name") \(fullName ?? "Unknown fullName") \(shortName ?? "Unknown shortName") \(rating ?? -1.00)]"
    }
}

