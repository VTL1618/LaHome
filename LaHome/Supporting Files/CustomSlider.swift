//
//  CustomSlider.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 08.08.2022.
//

import UIKit

final class CustomSlider: UISlider {
    
    private let baseLayer = CALayer()
    private let trackLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setup()
        createBaseLayer()
        configureTrackLayer()
    }
    
    private func setup() {
        clear()
        createBaseLayer()
        createThumbImageView()
        configureTrackLayer()
        addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    private func clear() {
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        thumbTintColor = .clear
    }
    
    private func createBaseLayer() {
        baseLayer.backgroundColor = UIColor(red: 189 / 255, green: 189 / 255, blue: 189 / 255, alpha: 0.8).cgColor
        baseLayer.masksToBounds = true
        baseLayer.frame = .init(x: 0,
                                y: frame.height / 2.5,
                                width: frame.width,
                                height: frame.height)
        baseLayer.cornerRadius = baseLayer.frame.height / 4
        layer.insertSublayer(baseLayer, at: 0)
    }
    
    private func createThumbImageView() {
        let thumbSize = 1.8 * frame.height
        let thumbView = ThumbView(frame: .init(x: 0,
                                               y: 0,
                                               width: thumbSize,
                                               height: thumbSize))
        thumbView.layer.cornerRadius = thumbSize / 2
        let thumbSnapshot = thumbView.snapshot
        setThumbImage(thumbSnapshot, for: .normal)
        setThumbImage(thumbSnapshot, for: .highlighted)
        setThumbImage(thumbSnapshot, for: .application)
        setThumbImage(thumbSnapshot, for: .disabled)
        setThumbImage(thumbSnapshot, for: .focused)
        setThumbImage(thumbSnapshot, for: .reserved)
        setThumbImage(thumbSnapshot, for: .selected)
    }
    
    private func configureTrackLayer() {
        let firstColor = UIColor(red: 210 / 255, green: 152 / 255, blue: 238 / 255, alpha: 1).cgColor
        let secondColor = UIColor(red: 166 / 255, green: 20 / 255, blue: 217 / 255, alpha: 1).cgColor
        
        trackLayer.colors = [firstColor, secondColor]
        trackLayer.startPoint = .init(x: 0, y: 0.5)
        trackLayer.endPoint = .init(x: 1, y: 0.5)
        trackLayer.frame = .init(x: 0,
                                 y: frame.height / 2.5,
                                 width: (frame.width * CGFloat(value / maximumValue)),
                                 height: frame.height)
        trackLayer.cornerRadius = trackLayer.frame.height / 4
        layer.insertSublayer(trackLayer, at: 1)
    }
    
    @objc private func valueChanged(_ sender: CustomSlider) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let thumbRectA = thumbRect(forBounds: bounds,
                                   trackRect: trackRect(forBounds: bounds),
                                   value: value)
        trackLayer.frame = .init(x: 0,
                                 y: frame.height / 4,
                                 width: thumbRectA.midX,
                                 height: frame.height / 2)
        CATransaction.commit()
    }
}

final class ThumbView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor(red: 183 / 255, green: 122 / 255, blue: 231 / 255, alpha: 1)
        let middleView = UIView(frame: .init(x: frame.midX - 6,
                                             y: frame.midY - 6,
                                             width: 12,
                                             height: 12))
        
        middleView.backgroundColor = .white
        middleView.layer.cornerRadius = 6
        addSubview(middleView)
    }
}

extension UIView {
    
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return capturedImage
    }
}
