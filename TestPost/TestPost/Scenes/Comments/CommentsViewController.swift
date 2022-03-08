//
//  CommentsViewController.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import UIKit

protocol CommentsDisplayLogic : AnyObject {
    func displaySomething(viewModel: CommentsModels.GetComments.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: CommentsModels.Error.ViewModel, on queu: DispatchQueue)
}

class CommentsViewController: BaseViewController {
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var seachCommentsTexField: PostTextField! {
        //Observadores de propiedades (property observers)
        didSet {
            seachCommentsTexField?.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        }
    }
    var isFiltering: Bool {
        return seachCommentsTexField?.text?.isEmpty == false
    }

    var commentsFilter: [CommentsModels.GetComments.Response] = [] {
        didSet {
            commentsTableView.reloadData()
        }
    }
    var interactor: CommentsBusinessLogic?
    var router: (NSObjectProtocol & CommentsRoutingLogic & CommentsDataPassing)?
    var idComments: Int?
    var dataComments = [CommentsModels.GetComments.Response]()
    
    let cellCommentsNibName = "CommentsTableViewCell"

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
        let interactor = CommentsInteractor()
        let presenter = CommentsPresenter()
        let router = CommentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInitialData()
        settingsTableView()
        setupBackButton(title: "Comments")
    }
    
    
    
    @objc func loadInitialData() {
        showLoading()
        guard let idComments = idComments else {
            return
        }

        let request = CommentsModels.GetComments.Request(idPost: idComments)
        interactor?.doSomething(request: request)
    }
    
    func settingsTableView(){
        commentsTableView?.register(UINib.init(nibName: cellCommentsNibName, bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.reuseIdentifier)
        
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.estimatedRowHeight = CommentsTableViewCell.cellHeight
    }
    
    @objc private func searchTextFieldDidChange(_ textField: UITextField) {
        search()
    }
    
    private func search() {
        if let text = seachCommentsTexField?.text?.lowercased() {
            commentsFilter = (dataComments.filter({ (so) -> Bool in
                return (so.body!.lowercased().contains(text))
            }))
        }
    }
    
}

extension CommentsViewController: CommentsDisplayLogic{
    func displaySomething(viewModel: CommentsModels.GetComments.ViewModel, on queu: DispatchQueue) {
        hideLoading()
        dataComments = viewModel.commentsData
        commentsTableView.reloadData()
    }
    
    func displayError(viewModel: CommentsModels.Error.ViewModel, on queu: DispatchQueue) {
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

extension CommentsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? commentsFilter.count : dataComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.reuseIdentifier, for: indexPath) as? CommentsTableViewCell else { fatalError() }
        
        let comments = isFiltering ? commentsFilter[indexPath.row] : dataComments[indexPath.row]
        cell.configUI(dataComments: comments)
        
        switch indexPath.row % 2 {
            case 0:
                cell.constrainstView.constant = 20
                cell.emailConstrainst.constant = 20
                cell.contrainstReighView.constant = 120
            case 1:
                cell.constrainstView.constant = 120
                cell.contrainstReighView.constant = 20
                cell.emailConstrainst.constant = 125
                
            default: break
        }
        
        return cell
    }
}
