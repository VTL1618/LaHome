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
        
    private var viewModel: HomeScreenViewModelProtocol! {
        didSet {
            viewModel.fetchDevices {
                self.devicesListCollectionView.reloadData()
            }
        }
    }
    
    var didSelectHandlerLampe: ((LampeControlViewModelProtocol) -> ())?
    var didSelectHandlerRoulant: ((RoulantControlViewModelProtocol) -> ())?
    var didSelectHandlerRadiateur: ((RadiateurControlViewModelProtocol) -> ())?
    
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
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        devicesListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        devicesListCollectionView.backgroundColor = .clear
        devicesListCollectionView.showsHorizontalScrollIndicator = false
        devicesListCollectionView.showsVerticalScrollIndicator = false
        
        devicesListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        titleForDevicesList = UILabel()
        titleForDevicesList.textColor = .white
        titleForDevicesList.font = UIFont(name: "avenir", size: 20)
        titleForDevicesList.text = NSLocalizedString("HomeScreenViewController_Label_titleForDevicesList", comment: "")
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
        devicesListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        devicesListCollectionView.register(LampesListCollectionViewCell.self, forCellWithReuseIdentifier: LampesListCollectionViewCell.reuseId)
        devicesListCollectionView.register(RoulantsListCollectionViewCell.self, forCellWithReuseIdentifier: RoulantsListCollectionViewCell.reuseId)
        devicesListCollectionView.register(RadiateurListCollectionViewCell.self, forCellWithReuseIdentifier: RadiateurListCollectionViewCell.reuseId)

        devicesListCollectionView.dataSource = self
        devicesListCollectionView.delegate = self
    }
}

// MARK: - Collection View DataSource
extension HomeScreenViewController: UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewModel.numberOfCellsLampe()
        } else if section == 1 {
            return viewModel.numberOfCellsRoulant()
        } else {
            return viewModel.numberOfCellsRadiateur()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LampesListCollectionViewCell.reuseId, for: indexPath) as! LampesListCollectionViewCell
            
            cell.viewModel = viewModel.cellViewModelLampe(at: indexPath)
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            didSelectHandlerLampe = { [weak self] device in
                
                let deviceController = LampeControlViewController()
                deviceController.navigationItem.title = NSLocalizedString("lampes_deviceName_\(device.deviceName)", comment: "")
                deviceController.viewModel = device
                
                self?.navigationController?.pushViewController(deviceController, animated: true)
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoulantsListCollectionViewCell.reuseId, for: indexPath) as! RoulantsListCollectionViewCell
            
            cell.viewModel = viewModel.cellViewModelRoulant(at: indexPath)
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            didSelectHandlerRoulant = { [weak self] device in
                
                let deviceController = RoulantControlViewController()
                deviceController.navigationItem.title = NSLocalizedString("roulants_deviceName_\(device.deviceName)", comment: "")
                deviceController.viewModel = device
                
                self?.navigationController?.pushViewController(deviceController, animated: true)
            }
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RadiateurListCollectionViewCell.reuseId, for: indexPath) as! RadiateurListCollectionViewCell
            
            cell.viewModel = viewModel.cellViewModelRadiateur(at: indexPath)
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            didSelectHandlerRadiateur = { [weak self] device in
                
                let deviceController = RadiateurControlViewController()
                deviceController.navigationItem.title = NSLocalizedString("radiateurs_deviceName_\(device.deviceName)", comment: "")
                deviceController.viewModel = device
                
                self?.navigationController?.pushViewController(deviceController, animated: true)
            }
            
            return cell
        }
    }
}
 
// MARK: - Collection View DelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let deviceControlViewModel = viewModel.viewModelForSelectedCellLampe(at: indexPath)
            didSelectHandlerLampe?(deviceControlViewModel)
        } else if indexPath.section == 1 {
            let deviceControlViewModel = viewModel.viewModelForSelectedCellRoulant(at: indexPath)
            didSelectHandlerRoulant?(deviceControlViewModel)
        } else {
            let deviceControlViewModel = viewModel.viewModelForSelectedCellRadiateur(at: indexPath)
            didSelectHandlerRadiateur?(deviceControlViewModel)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: (view.frame.width - 16 - 32) / 3,
                   height: (view.frame.width - 16 - 32) / 3)
        } else if indexPath.section == 1 {
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
        } else if section == 1 {
            return UIEdgeInsets(top: 20,
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
