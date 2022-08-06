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
    
    private var devices: [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScrollView()
        setupDevicesListCollectionView()
        getDevices()
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
        layout.itemSize = CGSize(width: (view.frame.width - 16 - 32) / 3,
                                 height: (view.frame.width - 16 - 32) / 3)
        
        devicesListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        devicesListCollectionView.backgroundColor = .cyan
        devicesListCollectionView.showsHorizontalScrollIndicator = false
        devicesListCollectionView.showsVerticalScrollIndicator = false
        devicesListCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                              left: 16,
                                                              bottom: 0,
                                                              right: 16)
        
        devicesListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        titleForDevicesList = UILabel()
        titleForDevicesList.textColor = .gray
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
//        devicesListCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        devicesListCollectionView.dataSource = self
        devicesListCollectionView.delegate = self
    }
    
    private func getDevices() {
        NetworkManager.shared.fetchData { devices in
            self.devices = devices
            DispatchQueue.main.async {
                self.devicesListCollectionView.reloadData()
            }
        }
    }
}

// MARK: - Collection View DataSource
extension HomeScreenViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DevicesListCollectionViewCell.reuseId, for: indexPath) as! DevicesListCollectionViewCell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let device = devices[indexPath.item]
        cell.setCell(with: device)
        
        cell.backgroundColor = .orange
        cell.clipsToBounds = true

        return cell
    }
}

// MARK: - Collection View Delegate
//extension HomeScreenViewController: UICollectionViewDelegate {
//
//}

// MARK: - Collection View DelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 8
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 8
//    }
}
