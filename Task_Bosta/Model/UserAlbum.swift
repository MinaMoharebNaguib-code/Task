//
//  Album.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 19/02/2023.
//

import Foundation
// MARK: - Album
class UserAlbum: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case id, title
        }
    
    init(userID: Int, id: Int, title: String) {
        self.userID = userID
        self.id = id
        self.title = title
    }
}
