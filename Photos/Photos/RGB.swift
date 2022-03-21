//
//  Color.swift
//  Photos
//
//  Created by 박진섭 on 2022/03/21.
//

import Foundation

class RGB {
    private(set) var red: Int
    private(set) var green: Int
    private(set) var blue: Int
    
    init(red: Int, green: Int, blue: Int) {
        let minValue = 0
        let maxValue = 255
        
        self.red = red < minValue ? minValue : (red > maxValue ? maxValue : red)
        self.green = green < minValue ? minValue : (green > maxValue ? maxValue : green)
        self.blue = blue < minValue ? minValue : (blue > maxValue ? maxValue : blue)
    }
}
