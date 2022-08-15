//
//  ViewController.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
        
    var devicesListCollectionView: UICollectionView!
    var titleForDevicesList: UILabel!
    
    private var sectionNow = Int()
    
    private var viewModel: HomeScreenViewModelProtocol! {
        didSet {
            viewModel.fetchDevices {
                self.devicesListCollectionView.reloadData()
            }
        }
    }
    
    var didSelectHandler: ((DeviceControlViewModelProtocol) -> ())?
    var didSelectHandlerLampe: ((LampeControlViewModelProtocol) -> ())?
    
    private let primaryColor = UIColor(
        red: 117/255,
        green: 207/255,
        blue: 221/255,
        alpha: 1
    )
    
    private let secondaryColor = UIColor(
        red: 107/255,
        green: 148/255,
        blue: 230/255,
        alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeScreenViewModel()
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        setupScrollView()
        setupDevicesListCollectionView()
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.devicesListCollectionView.reloadData()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupDevicesListCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
//        layout.collectionView?.backgroundColor = .clear
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
//        layout.itemSize = CGSize(width: (view.frame.width - 16 - 32) / 3,
//                                 height: (view.frame.width - 16 - 32) / 3)
        
        devicesListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        devicesListCollectionView.backgroundColor = .clear
        devicesListCollectionView.showsHorizontalScrollIndicator = false
        devicesListCollectionView.showsVerticalScrollIndicator = false
//        devicesListCollectionView.contentInset = UIEdgeInsets(top: 0,
//                                                              left: 16,
//                                                              bottom: 0,
//                                                              right: 16)
        
        devicesListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        titleForDevicesList = UILabel()
        titleForDevicesList.textColor = .white
        titleForDevicesList.font = UIFont(name: "avenir", size: 20)
        titleForDevicesList.text = "Devices"
        titleForDevicesList.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleForDevicesList)
        contentView.addSubview(devicesListCollectionView)
        
        titleForDevicesList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        titleForDevicesList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleForDevicesList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        titleForDevicesList.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        devicesListCollectionView.topAnchor.constraint(equalTo: titleForDevicesList.bottomAnchor, constant: 0).isActive = true
        devicesListCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        devicesListCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        devicesListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        devicesListCollectionView.register(DevicesListCollectionViewCell.self, forCellWithReuseIdentifier: DevicesListCollectionViewCell.reuseId)
        devicesListCollectionView.register(LampesListCollectionViewCell.self, forCellWithReuseIdentifier: LampesListCollectionViewCell.reuseId)

        devicesListCollectionView.dataSource = self
        devicesListCollectionView.delegate = self
    }
    
//    private func getDevices() {
//        NetworkManager.shared.fetchData { devices in
//            self.devices = devices
//            DispatchQueue.main.async {
//                self.devicesListCollectionView.reloadData()
//            }
//        }
//    }
}

// MARK: - Collection View DataSource
extension HomeScreenViewController: UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            self.sectionNow = section
            return viewModel.numberOfCells()
        } else {
            self.sectionNow = section
            return viewModel.numberOfCellsLampe()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DevicesListCollectionViewCell.reuseId, for: indexPath) as! DevicesListCollectionViewCell
            
            cell.viewModel = viewModel.cellViewModel(at: indexPath)
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            didSelectHandler = { [weak self] device in
                
                let deviceController = DeviceControlViewController()
                deviceController.navigationItem.title = device.deviceName
                deviceController.viewModel = device
                
                self?.navigationController?.pushViewController(deviceController, animated: true)
            }
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LampesListCollectionViewCell.reuseId, for: indexPath) as! LampesListCollectionViewCell
            
            cell.viewModel = viewModel.cellViewModelLampe(at: indexPath)
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            didSelectHandlerLampe = { [weak self] device in
                
                let deviceController = LampeControlViewController()
                deviceController.navigationItem.title = device.deviceName
                deviceController.viewModel = device
                
                self?.navigationController?.pushViewController(deviceController, animated: true)
            }
            
            return cell
        }
//        else {
//            return cell
//        }
    }
}
 
// MARK: - Collection View DelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let deviceControlViewModel = viewModel.viewModelForSelectedCell(at: indexPath)
    //        print(viewModel.devices[indexPath.item])
            didSelectHandler?(deviceControlViewModel)
        } else {
            let deviceControlViewModel = viewModel.viewModelForSelectedCellLampe(at: indexPath)
    //        print(viewModel.devices[indexPath.item])
            didSelectHandlerLampe?(deviceControlViewModel)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: (view.frame.width - 16 - 32) / 3,
                   height: (view.frame.width - 16 - 32) / 3)
        } else {
            return CGSize(width: (view.frame.width - 16 - 32) / 3,
                   height: (view.frame.width - 16 - 32) / 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 0,
                                left: 16,
                                bottom: 0,
                                right: 16)
        } else {
            return UIEdgeInsets(top: 20,
                                left: 16,
                                bottom: 0,
                                right: 16)
        }
    }
}

extension HomeScreenViewController {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
