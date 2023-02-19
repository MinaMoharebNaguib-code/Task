//
//  ViewController.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 18/02/2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var albumsTableView: UITableView!
    @IBOutlet weak var addressUser: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    let bag = DisposeBag()
    let profileViewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        getUser()
        subscribeToResponse()
        setup()
        getAlbums()
        tableViewBindWithViewModelAlbums()
    }
    func setup()
    {
        albumsTableView.register(UINib(nibName: "AlbumTVC", bundle: nil), forCellReuseIdentifier: "AlbumTVC")
        albumsTableView.reloadData()
        albumsTableView.tableFooterView = UIView()
    }
    func getUser()
    {
        let randomNumber = Int.random(in: 1...10)
        profileViewModel.getUser(id: randomNumber)
    }
    func getAlbums()
    {
        var userId = 0
        profileViewModel.userId.subscribe(onNext: {
            id in userId = id
            
        }).disposed(by: bag)
        profileViewModel.getAlbums(userId: userId)
    }
    func tableViewBindWithViewModelAlbums()
    {
        self.profileViewModel.albumsModelObservable.bind(to: self.albumsTableView.rx.items(cellIdentifier: "AlbumTVC", cellType: AlbumTVC.self)){
            row, data, cell in
            cell.albumName.text = data.title
        }.disposed(by: bag)
        self.albumsTableView.rx.itemSelected.subscribe(onNext: {
            index in
            self.albumsTableView.deselectRow(at: index, animated: true)
        }).disposed(by: bag)
        self.albumsTableView.rx.modelSelected(Album.self).subscribe(onNext: {album in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumsVC") as! AlbumsVC
            vc.dataId = album.id
            vc.title = album.title
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
    }
    func subscribeToResponse()
    {
        profileViewModel.nameObservable.bind(to: self.nameUser.rx.text).disposed(by: bag)
        profileViewModel.addressObservable.bind(to: self.addressUser.rx.text).disposed(by: bag)
    }

}
