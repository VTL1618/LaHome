//
//  ImageManager.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 05.08.2022.
//

import Foundation
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageName(by productType: String?) -> String {
        guard let productType = productType else { return "" }
        
        var imageName = String()
        
        switch productType {
        case "Light":
            imageName = "DeviceLightOnIcon"
        case "RollerShutter":
            imageName = "DeviceRollerShutterIcon"
        case "Heater":
            imageName = "DeviceHeaterOnIcon"
        default:
            imageName = ""
        }
        return imageName
    }
    
    func convertToGrayScale(image: UIImage) -> UIImage {
        // Create image rectangle with current image width/height
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)

        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height

        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context!.makeImage()

        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef!)

        return newImage
    }
}

extension UIImage {
    var grayscaled: UIImage? {
        let ciImage = CIImage(image: self)
        let grayscale = ciImage?.applyingFilter("CIColorControls",
                                                parameters: [ kCIInputSaturationKey: 0.0 ])
        if let gray = grayscale {
            return UIImage(ciImage: gray)
        }
        else {
            return nil
        }
    }
}
