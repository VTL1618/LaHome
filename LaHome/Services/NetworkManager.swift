//
//  NetworkManager.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 05.08.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let api = "http://storage42.com/modulotest/data.json"
    
    private init() {}
    
    func fetchData(completion: @escaping (_ devices: [Device]) -> Void) {
        
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description for error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let devices = try decoder.decode([Device].self, from: data)
                DispatchQueue.main.async {
                    completion(devices)
                }
            } catch let error {
                print("Error of serialization JSON", error)
            }

        }.resume()
    }
}
