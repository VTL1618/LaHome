//
//  Device.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 05.08.2022.
//

import Foundation

struct Device: Codable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let position: Int?
    let temperature: Int?
    let productType: String
}
