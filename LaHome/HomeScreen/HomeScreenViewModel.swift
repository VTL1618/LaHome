//
//  HomeScreenViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import Foundation

protocol HomeScreenViewModelProtocol: AnyObject {
    var devices: [Device] { get }
    func fetchDevices(completion: @escaping() -> Void)
    func numberOfCells() -> Int
    func cellViewModel(at indexPath: IndexPath) -> DevicesListCollectionViewCellViewModelProtocol
    func viewModelForSelectedCell(at indexPath: IndexPath) -> DeviceControlViewModelProtocol
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {
    var devices: [Device] = []
    
    func fetchDevices(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] devices in
            self.devices = devices
            completion()
        }
    }
    
    func numberOfCells() -> Int {
        devices.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> DevicesListCollectionViewCellViewModelProtocol {
        
        let device = devices[indexPath.item]
        return DevicesListCollectionViewCellViewModel(device: device)
    }
    
    func viewModelForSelectedCell(at indexPath: IndexPath) -> DeviceControlViewModelProtocol {
        
        let device = devices[indexPath.item]
        return DeviceControlViewModel(device: device)
    }
}
