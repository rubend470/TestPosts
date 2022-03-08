//
//  AlbumInteractor.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

protocol AlbumBusinessLogic {
    func doSomething(request: AlbumModels.GetAlbum.Request)
}

protocol AlbumDataStore {
}

class AlbumInteractor: AlbumBusinessLogic, AlbumDataStore {
    var presenter: AlbumPresentationLogic?
    var worker: AlbumServiceProtocol
    
    init(worker: AlbumServiceProtocol = AlbumAPI()) {
        self.worker = worker
    }
    
    // MARK: Do something
    func doSomething(request: AlbumModels.GetAlbum.Request) {
        worker.getAlbum(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentSomething(response: response)
            case .failure(let error):
                let response = AlbumModels.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }

    }
}
