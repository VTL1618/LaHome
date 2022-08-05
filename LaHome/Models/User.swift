//
//  User.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 06.08.2022.
//

import Foundation

struct User: Codable {
    let firstName: String?
    let lastName: String?
    let adress: Adress?
    let birthDate: Int?
}

struct Adress: Codable {
    let city: String?
    let postalCode: Int?
    let street: String?
    let streetCode: String?
    let country: String?
}