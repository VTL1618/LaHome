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
    
    func fetchRoulantData(completion: @escaping (_ devices: [Roulant]) -> Void) {
        
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description for error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let devices = try decoder.decode(RoulantResponse.self, from: data)
                let filteredDevices = devices.devices.filter { $0.productType == "RollerShutter" }
                print("FILTERED ROULANT - \(filteredDevices)")
                DispatchQueue.main.async {
                    completion(filteredDevices)
                }
            } catch let error {
                print("Error of serialization JSON", error)
            }

        }.resume()
    }
    
    func fetchRadiateurData(completion: @escaping (_ devices: [Radiateur]) -> Void) {
        
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description for error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let devices = try decoder.decode(RadiateurResponse.self, from: data)
                let filteredDevices = devices.devices.filter { $0.productType == "Heater" }
                print("FILTERED RADIATEUR - \(filteredDevices)")
                DispatchQueue.main.async {
                    completion(filteredDevices)
                }
            } catch let error {
                print("Error of serialization JSON", error)
            }

        }.resume()
    }
}
