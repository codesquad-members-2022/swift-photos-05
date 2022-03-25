//
//  DoodleViewController.swift
//  PhotoAlbum
//
//  Created by 안상희 on 2022/03/25.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    
    let session = URLSession.shared
    
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
        
        for doodle in myDoodles {
            guard let url = URL(string: doodle.image) else { return }
            
        }
        

    }
    
    
    
    
    
}
