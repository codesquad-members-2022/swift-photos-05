//
//  DoodleViewController.swift
//  PhotoAlbum
//
//  Created by 안상희 on 2022/03/25.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    
    let session = URLSession.shared
    var doodleList = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        fetch()
    }
    
    private func fetch() {
        guard let path = Bundle.main.path(forResource: "doodle", ofType: "json") else { return }
        
        guard let jsonString = try? String(contentsOfFile: path) else { return }
        
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        
        guard let data = data else { return }
        
        guard let myDoodles = try? decoder.decode([Doodle].self, from: data) else { return }
        
        for i in 0..<myDoodles.count {
            guard let url = URL(string: myDoodles[i].image) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print((response as? HTTPURLResponse)?.statusCode)
                    return
                }
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let imageView = UIImageView(image: UIImage(data: data))
                    self.doodleList.append(imageView)
                    self.collectionView.reloadData()
                }
                
            }.resume()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoodleCell", for: indexPath) as? DoodleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = doodleList[indexPath.item].image
        DispatchQueue.main.async {
            cell.imageView.image = image
        }
        return cell
    }
    
}
