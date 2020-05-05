//
//  LoginModel.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
struct LoginModel: Codable {
    let status: Int?
    let message: String?
    let data: LoginModelDataClass?
}

// MARK: - DataClass
struct LoginModelDataClass: Codable {
    let id: Int?
    let name, email: String?
    let bloodType, phone, address, longitude: JSONNull?
    let latitude, emailVerifiedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name, email, bloodType, phone, address, longitude, latitude
        case emailVerifiedAt = "email_verified_at"
    }
}

// MARK: - Encode/decode helpers

class JSONNul: Codable, Hashable {

    public static func == (lhs: JSONNul, rhs: JSONNul) -> Bool {
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
