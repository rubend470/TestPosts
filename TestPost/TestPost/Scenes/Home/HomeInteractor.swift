//
//  HomeInteractor.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation

protocol HomeBusinessLogic {
    func doSomething(request: HomeModels.GetHome.Request)
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeServiceProtocol
    
    init(worker: HomeServiceProtocol = HomeAPI()) {
        self.worker = worker
    }
    
    // MARK: Do something
    func doSomething(request: HomeModels.GetHome.Request) {
        worker.getHome(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentSomething(response: response)
            case .failure(let error):
                let response = HomeModels.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }

    }
}
