//
//  AlbumViewController.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import UIKit

protocol AlbumDisplayLogic : AnyObject {
    func displaySomething(viewModel: AlbumModels.GetAlbum.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: AlbumModels.Error.ViewModel, on queu: DispatchQueue)
}

class AlbumViewController: BaseViewController {
    
    @IBOutlet weak var AlbumCollectionView: UICollectionView!
    
    var idAlbum : Int?
    var photoData = [AlbumModels.GetAlbum.Response]()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - Collection View
    let cellAlbumCollectionNibName = "AlbumCollectionViewCell"
    
    var interactor: AlbumBusinessLogic?
    var router: (NSObjectProtocol & AlbumRoutingLogic & AlbumDataPassing)?
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = AlbumInteractor()
        let presenter = AlbumPresenter()
        let router = AlbumRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsCollectionView()
        loadInitialData()
        setupBackButton(title: "Album")
    }
    
    @objc func loadInitialData() {
        showLoading()
        
        guard let idAlbum = idAlbum else {
            return
        }
    
        let request = AlbumModels.GetAlbum.Request(idPost: idAlbum)
        interactor?.doSomething(request: request)
    }
    
    func settingsCollectionView(){
        AlbumCollectionView.register(UINib(nibName: cellAlbumCollectionNibName, bundle: nil),
                                forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier)
        
        AlbumCollectionView.refreshControl = refresher
    }
}

extension AlbumViewController : AlbumDisplayLogic {
    func displaySomething(viewModel: AlbumModels.GetAlbum.ViewModel, on queu: DispatchQueue) {
        hideLoading()
        photoData = viewModel.albumData
        AlbumCollectionView.reloadData()
    }
    
    func displayError(viewModel: AlbumModels.Error.ViewModel, on queu: DispatchQueue) {
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

extension AlbumViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = AlbumCollectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier, for: indexPath) as? AlbumCollectionViewCell else {
            fatalError()
        }
        let dataPhoto = photoData[indexPath.row]
        cell.configUI(dataPhoto: dataPhoto)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: AlbumCollectionViewCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
}

