//
//  Service.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 19/02/2023.
//

import Foundation
import Moya

enum Service{
    case readUser(id: Int)
    case readAlbum(userId: Int)
    case readAlbumDetails(albumId: Int)
}

extension Service: TargetType{
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self{
        case .readUser(let id):
            return "/users/\(id)"
        case .readAlbum(let userId):
            return "/users/\(userId)/albums"
        case .readAlbumDetails(let albumId):
            return "/albums/\(albumId)/photos"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .readUser(_):
            return .get
        case .readAlbum(_):
            return .get
        case .readAlbumDetails(_):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .readUser(_):
            return .requestPlain
        case .readAlbum(_):
            return .requestPlain
        case .readAlbumDetails(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json; charset=utf-8"]
    }
    
}

extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
