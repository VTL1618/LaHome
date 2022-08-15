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
                let devices = try decoder.decode(Response.self, from: data)
                print("DEVICES - \(devices.devices)")
                DispatchQueue.main.async {
                    completion(devices.devices)
                }
            } catch let error {
                print("Error of serialization JSON", error)
            }

        }.resume()
    }
    
    func fetchLampeData(completion: @escaping (_ devices: [Lampe]) -> Void) {
        
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description for error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let devices = try decoder.decode(LampeResponse.self, from: data)
                let filteredDevices = devices.devices.filter { $0.productType == "Light" }
                print("FILTERED - \(filteredDevices)")
                DispatchQueue.main.async {
                    completion(filteredDevices)
                }
            } catch let error {
                print("Error of serialization JSON", error)
            }

        }.resume()
    }
}
