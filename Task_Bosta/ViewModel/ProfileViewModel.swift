//
//  ProfileViewModel.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 18/02/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class ProfileViewModel{
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    //
    private let networkManager = NetworkManager()
    // User
    var userModelSubject = PublishSubject<User>()
    var userName : BehaviorRelay<String> = .init(value: "")
    var userAddress : BehaviorRelay<String> = .init(value: "")
    var userId : BehaviorRelay<Int> = .init(value: 1)
    var userModelObservable: Observable<User>{
        return userModelSubject
    }
    var nameObservable: Observable<String>{
        return userName.asObservable()
    }
    var addressObservable: Observable<String>{
        return userAddress.asObservable()
    }
    var userIdObservable: Observable<Int>{
        return userId.asObservable()
    }
    
    // Albums
    var albumsModelSubject = PublishSubject<[UserAlbum]>()
    var albumsModelObservable: Observable<[UserAlbum]>{
        return albumsModelSubject
    }
    
    // MARKS:- User
    // MARKS:- getUserWithMoya

    func getUser(id:Int)
    {
        networkManager.fetchUser(id: id, completion: {
            [weak self] result in
                    switch result {
                    case .success(let userResponse):
                        self!.userModelSubject.onNext(userResponse)
                        self!.userName.accept(userResponse.name)
                        self!.userAddress.accept("\(userResponse.address.street), \(userResponse.address.suite), \(userResponse.address.city), \n\(userResponse.address.zipcode)")
                        self!.userId.accept(userResponse.id)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
        })
    }
    
    // MARKS:- Albums
    func getAlbums(userId: Int)
    {
        networkManager.fetchUserAlbums(userId: userId, completion: {
            [weak self] result in
                    switch result {
                    case .success(let albumsResponse):
                        self!.albumsModelSubject.onNext(albumsResponse)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
        })
    }
}
