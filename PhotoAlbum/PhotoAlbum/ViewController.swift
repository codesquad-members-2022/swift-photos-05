//
//  ViewController.swift
//  Photos
//
//  Created by 안상희 on 2022/03/21.
//

import Photos
import UIKit

class ViewController: UIViewController {
    var allPhotos: PHFetchResult<PHAsset>?
    let imageManager = PHCachingImageManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allPhotos = PHAsset.fetchAssets(with: nil) // 조건 (nil)에 맞는 모든 asset 가져오기
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData() // 화면 전환할 때마다 데이터 reload
    }
}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellCount:Int = 40
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = self.allPhotos?.object(at: indexPath.item)
        let cellIdentifier = "imageCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = 80
        return CGSize(width: length, height: length)
    }
}
