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
    var albumDetailsModelSubject = PublishSubject<[PhotosAlbum]>()
    var albumDetailsObservable : Observable<[PhotosAlbum]>{
        return albumDetailsModelSubject
    }
    
//    func getPhotosAlbum(albumId: Int)
//    {
//        loadingBehavior.accept(true)
//        guard let getURL = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)") else {return}
//        let header = ["Content-Type":"application/json; charset=utf-8"]
//        let AlamoHeader = HTTPHeaders(header)
//
//        AF.request(getURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: AlamoHeader).responseJSON { (response) in
//
//            switch response.result{
//            case .success(_):
//
//                guard let data = response.data else {return}
//
//                do{
//                    let photosAlbum = try JSONDecoder().decode([PhotosAlbum].self, from: data)
//                    self.albumDetailsModelSubject.onNext(photosAlbum)
//
//                }catch{
//                    print(error.localizedDescription)
//                    self.loadingBehavior.accept(false)
//                }
//
//
//            case .failure(_):
//                print(response.error?.localizedDescription ?? "")
//                self.loadingBehavior.accept(false)
//            }
//
//            }
//    }
    
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
