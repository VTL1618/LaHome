//
//  RoulantResponse.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 16.08.2022.
//

import Foundation

struct RoulantResponse: Decodable {
    
    var devices: [Roulant]
    
    enum CodingKeys: String, CodingKey {
        
        case devices
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.devices = try container.decode([Roulant].self, forKey: .devices)
                
    }
    
}
