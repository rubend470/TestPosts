//
//  CommentsInteractor.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

protocol CommentsBusinessLogic {
    func doSomething(request: CommentsModels.GetComments.Request)
}

protocol CommentsDataStore {
}

class CommentsInteractor: CommentsBusinessLogic, CommentsDataStore {
    var presenter: CommentsPresentationLogic?
    var worker: CommentsServiceProtocol
    
    init(worker: CommentsServiceProtocol = CommentsAPI()) {
        self.worker = worker
    }
    
    // MARK: Do something
    func doSomething(request: CommentsModels.GetComments.Request) {
        worker.getComments(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentSomething(response: response)
            case .failure(let error):
                let response = CommentsModels.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }

    }
}
