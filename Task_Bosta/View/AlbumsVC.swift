//
//  AlbumsVC.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 18/02/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class AlbumsVC: UIViewController {
    
    var dataId: Int = 1
    @IBOutlet weak var collectionView: UICollectionView!
    let bag = DisposeBag()
    let albumDetails = AlbumDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        setup()
        getAlbumDetails()
        collectionViewBindWithViewModelAlbumDetails()
    }
    
    func setup()
    {
        collectionView.register(UINib(nibName: "PhotoAlumCVC", bundle: nil), forCellWithReuseIdentifier: "PhotoAlumCVC")
        collectionView.reloadData()
    }
    
    func getAlbumDetails()
    {
        //albumDetails.getPhotosAlbum(albumId: dataId)
        albumDetails.getAlbumDetails(albumId: dataId)
    }
    
    func collectionViewBindWithViewModelAlbumDetails()
    {
        self.collectionView.rx.setDelegate(self).disposed(by: bag)
        self.albumDetails.albumDetailsObservable.bind(to: self.collectionView.rx.items(cellIdentifier: "PhotoAlumCVC" , cellType: PhotoAlumCVC.self)){
            indexPath, title, cell in
            let url = URL(string: title.url)
            cell.albumImage.kf.setImage(with: url)
        }.disposed(by: bag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AlbumsVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3)
        return CGSize(width: width, height: width)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
}
