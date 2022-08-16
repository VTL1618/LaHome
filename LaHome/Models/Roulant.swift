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
    
//    enum CodingKeys: String, CodingKey {
//        
//        case devices
//        
//        case id
//        case deviceName
//        case position
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
//        self.position = try devicesContainer.decode(Int.self, forKey: .position)
//        self.productType = try devicesContainer.decode(String.self, forKey: .deviceName)
//    }
}

