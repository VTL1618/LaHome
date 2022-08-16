//
//  HomeScreenViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import Foundation

protocol HomeScreenViewModelProtocol: AnyObject {
//    var devices: [Device] { get }
    var lampes: [Lampe] { get }
    var roulant: [Roulant] { get }
    func fetchDevices(completion: @escaping() -> Void)
//    func fetchDevices(at section: Int, completion: @escaping() -> Void)
//    func numberOfCells() -> Int
    func numberOfCellsLampe() -> Int
    func numberOfCellsRoulant() -> Int
//    func cellViewModel(at indexPath: IndexPath) -> DevicesListCollectionViewCellViewModelProtocol
    func cellViewModelLampe(at indexPath: IndexPath) -> LampesListCollectionViewCellViewModelProtocol
    func cellViewModelRoulant(at indexPath: IndexPath) -> RoulantsListCollectionViewCellViewModelProtocol
//    func viewModelForSelectedCell(at indexPath: IndexPath) -> DeviceControlViewModelProtocol
    func viewModelForSelectedCellLampe(at indexPath: IndexPath) -> LampeControlViewModelProtocol
    func viewModelForSelectedCellRoulant(at indexPath: IndexPath) -> RoulantControlViewModelProtocol
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {
//    var devices: [Device] = []
    var lampes: [Lampe] = []
    var roulant: [Roulant] = []
    
    func fetchDevices(completion: @escaping () -> Void) {
//        if section == 0 {
//            NetworkManager.shared.fetchData { [unowned self] devices in
//                self.devices = devices
////                completion()
//            }
//        } else {
            NetworkManager.shared.fetchLampeData { [unowned self] devices in
                self.lampes = devices
                completion()
            }
        
        NetworkManager.shared.fetchRoulantData { [unowned self] devices in
            self.roulant = devices
            completion()
        }
//        }
    }
    
//    func numberOfCells() -> Int {
//        devices.count
//    }
    
    func numberOfCellsLampe() -> Int {
        lampes.count
    }
    
    func numberOfCellsRoulant() -> Int {
        roulant.count
    }
    
//    func cellViewModel(at indexPath: IndexPath) -> DevicesListCollectionViewCellViewModelProtocol {
//
//        let device = devices[indexPath.item]
//        return DevicesListCollectionViewCellViewModel(device: device)
//    }
    
    func cellViewModelLampe(at indexPath: IndexPath) -> LampesListCollectionViewCellViewModelProtocol {
        
        let device = lampes[indexPath.item]
        return LampesListCollectionViewCellViewModel(device: device)
    }
    
    func cellViewModelRoulant(at indexPath: IndexPath) -> RoulantsListCollectionViewCellViewModelProtocol {
        
        let device = roulant[indexPath.item]
        return RoulantsListCollectionViewCellViewModel(device: device)
    }
    
//    func viewModelForSelectedCell(at indexPath: IndexPath) -> DeviceControlViewModelProtocol {
//
//        let device = devices[indexPath.item]
//        return DeviceControlViewModel(device: device)
//    }
    
    func viewModelForSelectedCellLampe(at indexPath: IndexPath) -> LampeControlViewModelProtocol {
        
        let device = lampes[indexPath.item]
        return LampeControlViewModel(device: device)
    }
    
    func viewModelForSelectedCellRoulant(at indexPath: IndexPath) -> RoulantControlViewModelProtocol {
        
        let device = roulant[indexPath.item]
        return RoulantControlViewModel(device: device)
    }
}
