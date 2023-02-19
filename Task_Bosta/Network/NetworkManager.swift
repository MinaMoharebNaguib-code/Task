//
//  NetworkManager.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 19/02/2023.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<Service> { get }

    func fetchUser(id: Int, completion: @escaping (Result<User, Error>) -> ())
    func fetchUserAlbums(userId: Int, completion: @escaping (Result<[UserAlbum], Error>) -> ())
    func fetchAlbumDetails(albumId: Int, completion: @escaping (Result<[AlbumDetails], Error>) -> ())
}


class NetworkManager: Networkable{
    
    var provider = Moya.MoyaProvider<Service>(plugins: [NetworkLoggerPlugin()])
    
    func fetchUser(id: Int, completion: @escaping (Result<User, Error>) -> ()) {
        request(target: .readUser(id: id), completion: completion)
    }
    
    func fetchUserAlbums(userId: Int, completion: @escaping (Result<[UserAlbum], Error>) -> ()) {
        request(target: .readAlbum(userId: userId), completion: completion)
    }
    
    func fetchAlbumDetails(albumId: Int, completion: @escaping (Result<[AlbumDetails], Error>) -> ()) {
        request(target: .readAlbumDetails(albumId: albumId), completion: completion)
    }
}

private extension NetworkManager {
    
    private func request<T: Decodable>(target: Service, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
