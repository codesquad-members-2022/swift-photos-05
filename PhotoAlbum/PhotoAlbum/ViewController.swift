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
        
        switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
                PHPhotoLibrary.shared().register(self)
            default:
                PHPhotoLibrary.shared().register(self)
        }
//        fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureCachingPhotos()
    }
    
//    private func fetch() {
//        guard let path = Bundle.main.path(forResource: "doodle", ofType: "json") else { return }
//
//        guard let jsonString = try? String(contentsOfFile: path) else { return }
//
//        let decoder = JSONDecoder()
//        let data = jsonString.data(using: .utf8)
//
//        guard let data = data else { return }
//
//        guard let myDoodles = try? decoder.decode([Doodle].self, from: data) else { return }
//
//    }
    
    
    private func configureCachingPhotos() {
        let visibleCellCount = collectionView.visibleCells.count // 28
        let cachingPhotos = self.allPhotos!.objects(at: IndexSet(integersIn: visibleCellCount - 10..<allPhotos!.count)) // 18..<50
        imageManager.startCachingImages(for: cachingPhotos, targetSize: CGSize(width: 100, height: 100), contentMode: .default, options: nil)
        
    }
}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        inputCellImageWithPHAsset(cell: cell, at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = 100
        return CGSize(width: length, height: length)
    }
    
    
    private func inputCellImageWithPHAsset(cell:ImageCollectionViewCell,at indexPath:IndexPath) {
        if let asset = self.allPhotos?.object(at: indexPath.item) {
        
        cell.representedIdentifier = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: cell.frame.size, contentMode: .default, options: nil, resultHandler: {
            image, _ in if cell.representedIdentifier == asset.localIdentifier {
                cell.imageView.image = image
                cell.imageView.contentMode = .scaleToFill
                
                    }
                }
            )
        }
    }
}


/*
 1.변화가 일어남.
 2.변화가 일어난 사진만 다시 Fetch해서 allPhotos에 대입.
 3.UI바꾸기.(변화에 따라 바뀐쪽만 UI업데이트 - main thread)
*/
extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        //옵셔널 강제추출은 가능... guard let은 왜 안가능?
        DispatchQueue.main.sync {
            var phassetCollection = PHAssetCollection.transientAssetCollection(withAssetFetchResult: allPhotos!, title: "PhotoResult")
            
            if let albumChanges = changeInstance.changeDetails(for: phassetCollection) {
                phassetCollection = albumChanges.objectAfterChanges!
            }
            
            if let changes = changeInstance.changeDetails(for: allPhotos!) {
                allPhotos = changes.fetchResultAfterChanges
                collectionView.performBatchUpdates({

                    if let removed = changes.removedIndexes, removed.count > 0 {
                        collectionView.deleteItems(at: removed.map { IndexPath(item: $0, section:0) })
                    }
                    if let inserted = changes.insertedIndexes, inserted.count > 0 {
                        collectionView.insertItems(at: inserted.map { IndexPath(item: $0, section:0) })
                    }
                    if let changed = changes.changedIndexes, changed.count > 0 {
                        collectionView.reloadItems(at: changed.map { IndexPath(item: $0, section:0) })
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        self.collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                collectionView.reloadData()
            }
        }
    }

    
}
