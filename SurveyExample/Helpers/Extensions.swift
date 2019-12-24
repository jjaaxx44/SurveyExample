//
//  Extensions.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 20/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import UIKit

extension Data {
    func processData<T: Decodable>(classType: T.Type) -> Any? {
//        guard let data = data,
            let surveyAraay = try? JSONDecoder().decode(classType, from: self)
//            else {
//                return nil
//        }
        return surveyAraay
    }
}

extension UIView {
    func addBorder(borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

extension UIBarButtonItem {
    convenience init(compactImage: UIImage?, target: Any, action: Selector, forEvenr: UIPageControl.Event) {
        let testButton: UIButton = UIButton.init(type: .custom)
        testButton.setImage(compactImage, for: .normal)
        testButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        testButton.addTarget(target, action: action, for: forEvenr)
        self.init(customView: testButton)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
        
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
