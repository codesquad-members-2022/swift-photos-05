//
//  DoodleImage.swift
//  PhotoAlbum
//
//  Created by 안상희 on 2022/03/24.
//

import Foundation

struct DoodleImage: Codable {
    let doodleList: [Doodle]
    var doodleCount: Int {
        return self.doodleList.count
    }
    
    struct Doodle: Codable {
        let title: String
        let image: String
        let date: String
    }
}
