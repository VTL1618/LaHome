//
//  LampeResponse.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 15.08.2022.
//

struct LampeResponse: Decodable {
    var devices: [Lampe]
    
    enum CodingKeys: String, CodingKey {
        
        case devices
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.devices = try container.decode([Lampe].self, forKey: .devices)
                
    }
    
}
