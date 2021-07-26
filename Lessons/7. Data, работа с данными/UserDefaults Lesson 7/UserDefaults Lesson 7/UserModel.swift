//
//  UserModel.swift
//  UserDefaults Lesson 8
//
//  Created by Alexander Slobodjanjuk on 16.07.2021.
//

import Foundation

struct User: Codable {
    var name: String?
    var age: Int?
    var isMarried: Bool?
}
