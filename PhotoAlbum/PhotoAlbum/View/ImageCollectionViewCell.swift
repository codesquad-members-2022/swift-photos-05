//
//  ImageCollectionViewCell.swift
//  Photos
//
//  Created by 안상희 on 2022/03/21.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    var representedIdentifier: String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
