//
//  Response.swift
//  KPI Mobile
//
//  Created by Maxim Mamuta on 2/28/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//

struct ResponseMany<T: Decodable>: Decodable {
    let statusCode: Int
    let timeStamp: CLong
    let message: String
    let meta: Meta?
    let data: [T]
}

struct ResponseOne<T: Decodable>: Decodable {
    let statusCode: Int
    let timeStamp: CLong
    let message: String
    let data: T
}

struct Meta: Decodable {
    let total_count: String
    let offset: Int
    let limit: Int
}
