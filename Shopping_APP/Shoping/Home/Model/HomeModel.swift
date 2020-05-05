//
//  HomeModel.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/5/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

 import Foundation

// MARK: - WelcomeElement
struct Compines: Codable {
    let status: Bool?
    let error: String?
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let title: String?
    let image: String?
}
