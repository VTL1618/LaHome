//
//  DeviceControlViewController.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import UIKit

class DeviceControlViewController: UIViewController {
    
    var device: Device! {
        didSet {
            print("Device is -", device!)
        }
    }
    
    var viewModel: DeviceControlViewModelProtocol! {
        didSet {
            viewModel.viewModelDidChange = { [unowned self] viewModel in
                setModeForDeviceImage()
                setDeviceStateBar()
                print(viewModel.isSwitcherOn)
                print(viewModel.deviceModeForStatusBar + viewModel.deviceStateForStatusBar)
            }
            deviceImage.image = UIImage(named: viewModel.deviceImageName)
            deviceState.text = "\(viewModel.deviceModeForStatusBar)\(viewModel.deviceStateForStatusBar)"
            slider.value = viewModel.slider
            switcher.isOn = viewModel.isSwitcherOn
            switcher.isHidden = viewModel.switcherIsHidden
            labelOnMode.isHidden = viewModel.labelOnMode
            labelOffMode.isHidden = viewModel.labelOffMode
        }
    }
    
    private var deviceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var deviceState: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.text = "On / Off"
        label.backgroundColor = .red
        return label
    }()
    
    private var deviceModeForStatusBar = String()
    private var deviceStateForStatusBar = String()
    
    private var slider: CustomSlider = {
        let slider = CustomSlider()
//        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    private var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        switcher.isHidden = true
        
        switcher.addTarget(self, action: #selector(switcherPressed), for: .valueChanged)
        return switcher
    }()
    
    private var labelOnMode: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "—  On"
        label.isHidden = true
        return label
    }()
    
    private var labelOffMode: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Off  —"
        label.isHidden = true
        return label
    }()
    
    private let headerStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DeviceControlViewModel(device: device)
        
        view.addSubview(headerStackView)
        view.addSubview(slider)
        view.addSubview(switcher)
        view.addSubview(labelOnMode)
        view.addSubview(labelOffMode)

        view.backgroundColor = .white
        deviceState.backgroundColor = .green
        labelOnMode.backgroundColor = .orange
        labelOffMode.backgroundColor = .orange
        
        configureStackView()
        setElementsToStacks()
        setConstraintsForElements()
        setupUI()
    }
    
    private func configureStackView() {
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fill
        headerStackView.alignment = .center
        headerStackView.spacing = 10
        
        setStackViewConstraints()
    }
    
    private func setStackViewConstraints() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
    
        headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        headerStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setElementsToStacks() {
        headerStackView.addArrangedSubview(deviceImage)
        headerStackView.addArrangedSubview(deviceState)
    }
    
    private func setConstraintsForElements() {
        
        deviceImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        deviceImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        slider.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 100).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        slider.translatesAutoresizingMaskIntoConstraints = false

        switcher.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 100).isActive = true
        switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        switcher.translatesAutoresizingMaskIntoConstraints = false
        
        labelOnMode.leadingAnchor.constraint(equalTo: switcher.trailingAnchor, constant: 30).isActive = true
        labelOnMode.centerYAnchor.constraint(equalTo: switcher.centerYAnchor).isActive = true
        labelOnMode.translatesAutoresizingMaskIntoConstraints = false
        
        labelOffMode.trailingAnchor.constraint(equalTo: switcher.leadingAnchor, constant: -30).isActive = true
        labelOffMode.centerYAnchor.constraint(equalTo: switcher.centerYAnchor).isActive = true
        labelOffMode.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupUI() {
        setModeForDeviceImage()
        setDeviceStateBar()
    }
    
    @objc func switcherPressed() {
        viewModel.switcherPressed()
    }
    
    @objc func handleSliderChange() {
//        print(slider.value)
        viewModel.sliderChanged(to: slider.value)
    }
    
    private func setModeForDeviceImage() {
        deviceImage.image = viewModel.isSwitcherOn ? UIImage(named: viewModel.deviceImageName) : ImageManager.shared.convertToGrayScale(image: UIImage(named: viewModel.deviceImageName)!)
    }
    
    private func setDeviceStateBar() {
        deviceState.text = "\(viewModel.deviceModeForStatusBar)\(viewModel.deviceStateForStatusBar)"
    }
}
