//
//  PhotosAlbum.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 19/02/2023.
//

import Foundation
import SwiftyJSON

// MARK: - PhotosAlbum
class PhotosAlbum: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }

    init(albumID: Int, id: Int, title: String, url: String, thumbnailURL: String) {
        self.albumID = albumID
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailURL = thumbnailURL
    }
}
