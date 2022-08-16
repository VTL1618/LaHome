//
//  Roulant.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 12.08.2022.
//

import Foundation

struct Roulant: Decodable {
    let id: Int
    let deviceName: String
    let position: Int?
    let productType: String
}

