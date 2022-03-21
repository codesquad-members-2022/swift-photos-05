//
//  UIColor+Extension.swift
//  Photos
//
//  Created by 안상희 on 2022/03/21.
//

import UIKit

extension UIColor {
    convenience init(rgb: RGB) {
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(1))
    }
}
