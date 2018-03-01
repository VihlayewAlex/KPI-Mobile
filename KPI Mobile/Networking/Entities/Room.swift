//
//  Room.swift
//  KPI Mobile
//
//  Created by Maxim Mamuta on 3/1/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//

struct Room : Decodable {
    let id : Int?
    let name : String?
    let latitude : Double?
    let longitude : Double?
    
    enum CodingKeys: String, CodingKey {
        case room_id = "room_id"
        case room_name = "room_name"
        case room_latitude = "room_latitude"
        case room_longitude = "room_longitude"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard let _roomId = try Int(values.decode(String.self, forKey: .room_id)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.room_id], debugDescription: "Expecting string representation of Int"))
        }
        id = _roomId
        name = try values.decodeIfPresent(String.self, forKey: .room_name)
        guard let _roomLatitude = try Double(values.decode(String.self, forKey: .room_latitude)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.room_latitude], debugDescription: "Expecting string representation of Double"))
        }
        latitude = _roomLatitude
        guard let _roomLongitude = try Double(values.decode(String.self, forKey: .room_longitude)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.room_longitude], debugDescription: "Expecting string representation of Double"))
        }
        longitude = _roomLongitude
    }
}
