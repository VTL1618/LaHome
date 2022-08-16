//
//  Radiateur.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 12.08.2022.
//

struct Radiateur: Decodable {
    let id: Int
    let deviceName: String
    let mode: String?
    let temperature: Int?
    let productType: String
}
