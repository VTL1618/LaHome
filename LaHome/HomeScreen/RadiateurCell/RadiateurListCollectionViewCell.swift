//
//  RadiateurListCollectionViewCell.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 15.08.2022.
//

import UIKit

class RadiateurListCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "radiateurCell"
    
    var viewModel: RadiateursListCollectionViewCellViewModelProtocol! {
        didSet {
           // Set device Image
            deviceImage.image = UIImage(named: viewModel.deviceImageName)
            
            // Set device Name
            deviceName.text = NSLocalizedString("radiateurs_deviceName_\(viewModel.deviceName)", comment: "")
            
            // Set device State
            deviceState.text = "\(viewModel.deviceState)°"
            
            setModeForDeviceImage()
        }
    }
        
    private let deviceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var deviceName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Home device"
        return label
    }()
    
    private var deviceState: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .left
        label.text = "On / Off"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(deviceImage)
        contentView.addSubview(deviceName)
        contentView.addSubview(deviceState)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        deviceImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        deviceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        deviceImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        deviceImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        deviceImage.translatesAutoresizingMaskIntoConstraints = false
        
        deviceName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        deviceName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        deviceName.bottomAnchor.constraint(equalTo: deviceState.topAnchor, constant: -3).isActive = true
        deviceName.translatesAutoresizingMaskIntoConstraints = false

        deviceState.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        deviceState.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        deviceState.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        deviceState.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setModeForDeviceImage() {
        if viewModel.isSwitcherOn == true {
            deviceImage.image = UIImage(named: viewModel.deviceImageName)
        } else {
            deviceImage.image = ImageManager.shared.convertToGrayScale(image: UIImage(named: viewModel.deviceImageName)!)
        }
    }
}
