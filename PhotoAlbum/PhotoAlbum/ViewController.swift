//
//  ViewController.swift
//  Photos
//
//  Created by 안상희 on 2022/03/21.
//

import Photos
import UIKit

final class ViewController: UIViewController {
    private var allPhotos: PHFetchResult<PHAsset>? // 가져올 asset
    private let cacheManager = PHCachingImageManager()
    private let imageManger = PHImageManager()
    
    
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
        return allPhotos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // allPhoto에서 indexPath에 해당하는 아이템을 가져와서 asset에 저장
        let asset = self.allPhotos?.object(at: indexPath.item)
        
        let cellIdentifier = "imageCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // asset의 고유 식별자를 cell의 식별자에 주입
        cell.representedIdentifier = asset?.localIdentifier
        
        // 이미지 불러오기
        imageManger.requestImage(for: asset!, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil, resultHandler: {
            // 이미지 불러오기 성공
            // 이전에 주입한 cell의 identifier와 asset의 identifier가 같은 경우, 이미지 넣기
            image, _ in if cell.representedIdentifier == asset?.localIdentifier {
                cell.imageView.image = image
            }
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = 100
        return CGSize(width: length, height: length)
    }
}
