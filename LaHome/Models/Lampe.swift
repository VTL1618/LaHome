//
//  Lampe.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 12.08.2022.
//

struct Lampe: Decodable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let productType: String
}
