//
//  AlbumDetailsViewModel.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 19/02/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class AlbumDetailsViewModel
{
    private let networkManager = NetworkManager()
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    // Album Details
    var albumDetailsModelSubject = PublishSubject<[AlbumDetails]>()
    var albumDetailsObservable : Observable<[AlbumDetails]>{
        return albumDetailsModelSubject
    }
    
    func getAlbumDetails(albumId: Int)
    {
        loadingBehavior.accept(true)
        networkManager.fetchAlbumDetails(albumId: albumId, completion: {
            [weak self] result in
                    switch result {
                    case .success(let albumDetailsResponse):
                        self!.albumDetailsModelSubject.onNext(albumDetailsResponse)
                        self!.loadingBehavior.accept(true)
                    case .failure(let error):
                        print(error.localizedDescription)
                        self!.loadingBehavior.accept(false)
                    }
        })
    }
}
