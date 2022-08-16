//
//  HomeScreenViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import Foundation

protocol HomeScreenViewModelProtocol: AnyObject {

    var lampes: [Lampe] { get }
    var roulant: [Roulant] { get }
    var radiateur: [Radiateur] { get }
    func fetchDevices(completion: @escaping() -> Void)

    func numberOfCellsLampe() -> Int
    func numberOfCellsRoulant() -> Int
    func numberOfCellsRadiateur() -> Int

    func cellViewModelLampe(at indexPath: IndexPath) -> LampesListCollectionViewCellViewModelProtocol
    func cellViewModelRoulant(at indexPath: IndexPath) -> RoulantsListCollectionViewCellViewModelProtocol
    func cellViewModelRadiateur(at indexPath: IndexPath) -> RadiateursListCollectionViewCellViewModelProtocol

    func viewModelForSelectedCellLampe(at indexPath: IndexPath) -> LampeControlViewModelProtocol
    func viewModelForSelectedCellRoulant(at indexPath: IndexPath) -> RoulantControlViewModelProtocol
    func viewModelForSelectedCellRadiateur(at indexPath: IndexPath) -> RadiateurControlViewModelProtocol
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {

    var lampes: [Lampe] = []
    var roulant: [Roulant] = []
    var radiateur: [Radiateur] = []
    
    func fetchDevices(completion: @escaping () -> Void) {

        NetworkManager.shared.fetchLampeData { [unowned self] devices in
            self.lampes = devices
            completion()
        }
        
        NetworkManager.shared.fetchRoulantData { [unowned self] devices in
            self.roulant = devices
            completion()
        }
        
        NetworkManager.shared.fetchRadiateurData { [unowned self] devices in
            self.radiateur = devices
            completion()
        }
    }
    
    func numberOfCellsLampe() -> Int {
        lampes.count
    }
    
    func numberOfCellsRoulant() -> Int {
        roulant.count
    }
    
    func numberOfCellsRadiateur() -> Int {
        radiateur.count
    }
    
    func cellViewModelLampe(at indexPath: IndexPath) -> LampesListCollectionViewCellViewModelProtocol {
        
        let device = lampes[indexPath.item]
        return LampesListCollectionViewCellViewModel(device: device)
    }
    
    func cellViewModelRoulant(at indexPath: IndexPath) -> RoulantsListCollectionViewCellViewModelProtocol {
        
        let device = roulant[indexPath.item]
        return RoulantsListCollectionViewCellViewModel(device: device)
    }
    
    func cellViewModelRadiateur(at indexPath: IndexPath) -> RadiateursListCollectionViewCellViewModelProtocol {
        
        let device = radiateur[indexPath.item]
        return RadiateurListCollectionViewCellViewModel(device: device)
    }
    
    func viewModelForSelectedCellLampe(at indexPath: IndexPath) -> LampeControlViewModelProtocol {
        
        let device = lampes[indexPath.item]
        return LampeControlViewModel(device: device)
    }
    
    func viewModelForSelectedCellRoulant(at indexPath: IndexPath) -> RoulantControlViewModelProtocol {
        
        let device = roulant[indexPath.item]
        return RoulantControlViewModel(device: device)
    }
    
    func viewModelForSelectedCellRadiateur(at indexPath: IndexPath) -> RadiateurControlViewModelProtocol {
        
        let device = radiateur[indexPath.item]
        return RadiateurControlViewModel(device: device)
    }
}
