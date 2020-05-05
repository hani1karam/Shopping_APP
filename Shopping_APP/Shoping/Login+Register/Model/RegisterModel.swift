//
//  RegisterModel.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

 
import Foundation

// MARK: - Welcome
struct RegisterModel: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let name, email: String?
    let address: JSONNull?
    let phone: String?
    let longitude, latitude: JSONNull?
    let id: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
