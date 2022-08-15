//
//  Lampe.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 12.08.2022.
//

import Foundation

struct Lampe: Decodable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let productType: String
    
//    enum CodingKeys: String, CodingKey {
//        
//        case devices
//        
//        case id
//        case deviceName
//        case intensity
//        case mode
//        case productType
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        let devicesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .devices)
//
//        self.id = try devicesContainer.decode(Int.self, forKey: .id)
//        self.deviceName = try devicesContainer.decode(String.self, forKey: .deviceName)
//        self.intensity = try devicesContainer.decode(Int.self, forKey: .intensity)
//        self.mode = try devicesContainer.decode(String.self, forKey: .mode)
//        self.productType = try devicesContainer.decode(String.self, forKey: .deviceName)
//    }
}
