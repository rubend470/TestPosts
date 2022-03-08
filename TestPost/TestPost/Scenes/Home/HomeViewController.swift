//
//  HomeViewController.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import UIKit

protocol HomeDisplayLogic : AnyObject {
    func displaySomething(viewModel: HomeModels.GetHome.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: HomeModels.Error.ViewModel, on queu: DispatchQueue)
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchTextField: PostTextField! {
        //Observadores de propiedades (property observers)
        didSet {
            searchTextField?.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        }
    }
    var isFiltering: Bool {
        return searchTextField?.text?.isEmpty == false
    }

    var postsFilter: [HomeModels.GetHome.Response] = [] {
        didSet {
            homeTableView.reloadData()
        }
    }
    var  observableAlbum: ((Int) -> Void)?
    var homePosts = [HomeModels.GetHome.Response]()
    
    var observableComments: ((Int) -> Void)?
    let cellHomeNibName = "HomePostTableViewCell"
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
  
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView()
        loadInitialData()
//        setupBackButton(title: "Posts")
        settingsNavBar(title: "Post")
        observableAlbum = { AlbumId in
            let vc = AlbumViewController()
            vc.idAlbum = AlbumId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        observableComments = { CommentsId in
            let vc = CommentsViewController()
            vc.idComments = CommentsId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - Methods
    func loadInitialData() {
        showLoading()
        let request = HomeModels.GetHome.Request()
        interactor?.doSomething(request: request)
    }
    
    func settingsTableView(){
        homeTableView?.register(UINib.init(nibName: cellHomeNibName, bundle: nil), forCellReuseIdentifier: HomePostTableViewCell.reuseIdentifier)
        
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.estimatedRowHeight = HomePostTableViewCell.cellHeight
    }
    
    @objc private func searchTextFieldDidChange(_ textField: UITextField) {
        search()
    }
    
    private func search() {
        if let text = searchTextField?.text?.lowercased() {
            postsFilter = (homePosts.filter({ (so) -> Bool in
                return (so.body!.lowercased().contains(text))
            }))
        }
    }
}

extension HomeViewController: HomeDisplayLogic {
    
    func displaySomething(viewModel: HomeModels.GetHome.ViewModel, on queu: DispatchQueue) {
        homePosts = viewModel.HomeData
        homeTableView.reloadData()
    }
    
    func displayError(viewModel: HomeModels.Error.ViewModel, on queu: DispatchQueue) {
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? postsFilter.count : homePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePostTableViewCell.reuseIdentifier, for: indexPath) as? HomePostTableViewCell else { fatalError() }

        hideLoading()
        
         let postData = isFiltering ? postsFilter[indexPath.row] : homePosts[indexPath.row]
            cell.configUI(dataPost: postData)
            cell.observableAlbum = observableAlbum
            cell.observableComments = observableComments
        
        
        return cell
    }
}
