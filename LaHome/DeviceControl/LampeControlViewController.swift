//
//  LampeControlViewController.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 13.08.2022.
//

import UIKit

class LampeControlViewController: UIViewController {
    
    var viewModel: LampeControlViewModelProtocol!
    
    private var deviceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var deviceState: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.text = "On / Off"
        return label
    }()
    
    private var deviceModeForStatusBar = String()
    private var deviceStateForStatusBar = String()
    
    private var slider: CustomSlider = {
        let slider = CustomSlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    private var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        switcher.addTarget(self, action: #selector(switcherPressed), for: .valueChanged)
        return switcher
    }()
    
    private var labelOnMode: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "—  On"
        return label
    }()
    
    private var labelOffMode: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "Off  —"
        return label
    }()
    
    private let headerStackView = UIStackView()
    
    private let productType: String = ""
    
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
        
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        view.addSubview(headerStackView)
        view.addSubview(slider)
        view.addSubview(switcher)
        view.addSubview(labelOnMode)
        view.addSubview(labelOffMode)

        view.backgroundColor = .white
        
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
        
        viewModel.viewModelDidChange = { [unowned self] viewModel in
            setModeForDeviceImage()
            setDeviceStateBar()
        }
        deviceImage.image = UIImage(named: viewModel.deviceImageName)
        deviceState.text = "\(viewModel.deviceModeForStatusBar)\(viewModel.deviceStateForStatusBar)%"
        slider.value = viewModel.slider
        switcher.isOn = viewModel.isSwitcherOn
    }
    
    @objc func switcherPressed() {
        viewModel.switcherPressed()
    }
    
    @objc func handleSliderChange() {
        viewModel.sliderChanged(to: slider.value)
    }
    
    private func setModeForDeviceImage() {
        if viewModel.isSwitcherOn == true {
            deviceImage.image = UIImage(named: viewModel.deviceImageName)
        } else {
            DispatchQueue.main.async {
                self.deviceImage.image = ImageManager.shared.convertToGrayScale(image: UIImage(named: self.viewModel.deviceImageName)!)
            }
        }
    }
    
    private func setDeviceStateBar() {
        deviceState.text = "\(viewModel.deviceModeForStatusBar)\(viewModel.deviceStateForStatusBar)%"
    }
}

extension LampeControlViewController {
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
