//
//  ViewController.swift
//  Photos
//
//  Created by 안상희 on 2022/03/21.
//

import Photos
import UIKit

final class ViewController: UIViewController {
    private var allPhotos: PHFetchResult<PHAsset>?
    private let imageManager = PHCachingImageManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allPhotos = PHAsset.fetchAssets(with: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureCachingPhotos()
    }
    
    private func configureCachingPhotos() {
        let visibleCellCount = collectionView.visibleCells.count // 28
        let cachingPhotos = self.allPhotos!.objects(at: IndexSet(integersIn: visibleCellCount - 10..<allPhotos!.count)) // 18..<50
        imageManager.startCachingImages(for: cachingPhotos, targetSize: CGSize(width: 100, height: 100), contentMode: .default, options: nil)
        imageManager.stopCachingImagesForAllAssets()
    }
}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = self.allPhotos?.object(at: indexPath.item)
        
        let cellIdentifier = "imageCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.representedIdentifier = asset?.localIdentifier
        
        imageManager.requestImage(for: asset!, targetSize: CGSize(width: 100, height: 100), contentMode: .default, options: nil, resultHandler: {
            image, _ in if cell.representedIdentifier == asset?.localIdentifier {
                cell.imageView.image = image
                cell.imageView.contentMode = .scaleToFill
            }
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = 100
        return CGSize(width: length, height: length)
    }
}
