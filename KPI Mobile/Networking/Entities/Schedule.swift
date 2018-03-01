//
//  Schedule.swift
//  KPI Mobile
//
//  Created by Maxim Mamuta on 3/1/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//
struct Schedule: Decodable {
    let lessonId : Int?
    let groupId : Int?
    let dayNumber : Int?
    let dayName : String?
    let lessonName : String?
    let lessonFullName : String?
    let lessonNumber : Int?
    let lessonRoom : String?
    let lessonType : String?
    let teacherName : String?
    let lessonWeek : Int?
    let timeStart : String?
    let timeEnd : String?
    let teachers : [Teacher]?
    let rooms : [Room]?
    
    enum CodingKeys: String, CodingKey {
        case lesson_id = "lesson_id"
        case group_id = "group_id"
        case day_number = "day_number"
        case day_name = "day_name"
        case lesson_name = "lesson_name"
        case lesson_full_name = "lesson_full_name"
        case lesson_number = "lesson_number"
        case lesson_room = "lesson_room"
        case lesson_type = "lesson_type"
        case teacher_name = "teacher_name"
        case lesson_week = "lesson_week"
        case time_start = "time_start"
        case time_end = "time_end"
        case teachers = "teachers"
        case rooms = "rooms"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard let _lessonId = try Int(values.decode(String.self, forKey: .lesson_id)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.lesson_id], debugDescription: "Expecting string representation of Int"))
        }
        lessonId = _lessonId
        guard let _groupId = try Int(values.decode(String.self, forKey: .group_id)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.group_id], debugDescription: "Expecting string representation of Int"))
        }
        groupId = _groupId
        guard let _dayNumber = try Int(values.decode(String.self, forKey: .day_number)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.day_number], debugDescription: "Expecting string representation of Int"))
        }
        dayNumber = _dayNumber
        dayName = try values.decodeIfPresent(String.self, forKey: .day_name)
        lessonName = try values.decodeIfPresent(String.self, forKey: .lesson_name)
        lessonFullName = try values.decodeIfPresent(String.self, forKey: .lesson_full_name)
        guard let _lessonNumber = try Int(values.decode(String.self, forKey: .lesson_number)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.lesson_number], debugDescription: "Expecting string representation of Int"))
        }
        lessonNumber = _lessonNumber
        lessonRoom = try values.decodeIfPresent(String.self, forKey: .lesson_room)
        lessonType = try values.decodeIfPresent(String.self, forKey: .lesson_type)
        teacherName = try values.decodeIfPresent(String.self, forKey: .teacher_name)
        guard let _lessonWeek = try Int(values.decode(String.self, forKey: .lesson_week)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.lesson_week], debugDescription: "Expecting string representation of Int"))
        }
        lessonWeek = _lessonWeek
        timeStart = try values.decodeIfPresent(String.self, forKey: .time_start)
        timeEnd = try values.decodeIfPresent(String.self, forKey: .time_end)
        teachers = try values.decodeIfPresent([Teacher].self, forKey: .teachers)
        rooms = try values.decodeIfPresent([Room].self, forKey: .rooms)
    }
}
