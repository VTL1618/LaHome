//
//  ScenariosCollectionViewCell.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import UIKit

class DevicesListCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "deviceCell"
        
    private let deviceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var deviceName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.text = "Home device"
        label.backgroundColor = .purple
        return label
    }()
    
    private var deviceState: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .left
        label.text = "On / Off"
        label.backgroundColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(deviceImage)
        contentView.addSubview(deviceName)
        contentView.addSubview(deviceState)
        
        contentView.backgroundColor = .lightGray
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        deviceImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        deviceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        deviceImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        deviceImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        deviceImage.translatesAutoresizingMaskIntoConstraints = false
        
        deviceName.topAnchor.constraint(equalTo: deviceImage.bottomAnchor, constant: 20).isActive = true
        deviceName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        deviceName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        deviceName.translatesAutoresizingMaskIntoConstraints = false

        deviceState.topAnchor.constraint(equalTo: deviceName.bottomAnchor, constant: 6).isActive = true
        deviceState.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        deviceState.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        deviceState.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setCell(with device: Device) {

        // Set device Name
        self.deviceName.text = device.deviceName
        
        // Set device State
        if let state = device.intensity {
            self.deviceState.text = "\(state)%"
        }
        if let state = device.position {
            self.deviceState.text = "position: \(state)"
        }
        if let state = device.temperature {
            self.deviceState.text = "\(state)°"
        }
        
        // Set device Image
        switch device.productType {
        case "Light":
            self.deviceImage.image = UIImage(named: "DeviceLightOnIcon")
        case "RollerShutter":
            self.deviceImage.image = UIImage(named: "DeviceRollerShutterIcon")
        case "Heater":
            self.deviceImage.image = UIImage(named: "DeviceHeaterOnIcon")
        default:
            self.deviceImage.image = UIImage(systemName: "house")
        }
    }
}
