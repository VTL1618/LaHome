//
//  LampeResponse.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 15.08.2022.
//

import Foundation

struct LampeResponse: Decodable {
    var devices: [Lampe]
//    let user: User
    
    enum CodingKeys: String, CodingKey {
        
        case devices
//        case user
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.devices = try container.decode([Lampe].self, forKey: .devices)
        
//        self.user = try container.decode(User.self, forKey: .user)
        
    }
    
}
