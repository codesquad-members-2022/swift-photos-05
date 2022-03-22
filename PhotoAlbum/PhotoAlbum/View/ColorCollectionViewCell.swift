//
//  ColorCollectionViewCell.swift
//  Photos
//
//  Created by 안상희 on 2022/03/21.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCell()
    }
    
    private func setUpCell() {
        let rgb = RGB.generateRandomColor()
        self.backgroundColor = UIColor(rgb: rgb)
    }
}
