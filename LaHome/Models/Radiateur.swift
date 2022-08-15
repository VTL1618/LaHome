//
//  Radiateur.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 12.08.2022.
//

import Foundation

struct Radiateur: Decodable {
    let id: Int
    let deviceName: String
    let mode: String?
    let temperature: Int?
    let productType: String
    
    enum CodingKeys: String, CodingKey {
        
        case devices
        
        case id
        case deviceName
        case mode
        case temperature
        case productType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let devicesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .devices)

        self.id = try devicesContainer.decode(Int.self, forKey: .id)
        self.deviceName = try devicesContainer.decode(String.self, forKey: .deviceName)
        self.temperature = try devicesContainer.decode(Int.self, forKey: .temperature)
        self.mode = try devicesContainer.decode(String.self, forKey: .mode)
        self.productType = try devicesContainer.decode(String.self, forKey: .deviceName)
    }
}
