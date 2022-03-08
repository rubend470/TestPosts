//
//  AlbumPresenter.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

protocol AlbumPresentationLogic {
    func presentSomething(response: [AlbumModels.GetAlbum.Response])
    func presentError(response: AlbumModels.Error.Response)
}

class AlbumPresenter: AlbumPresentationLogic {
    weak var viewController: AlbumDisplayLogic?
  
    // MARK: - Do something
    func presentSomething(response: [AlbumModels.GetAlbum.Response]) {
        let viewModel = AlbumModels.GetAlbum.ViewModel(albumData: response)
        viewController?.displaySomething(viewModel: viewModel, on: .main)
    }
    
    
    //MARK: - Present error
    func presentError(response: AlbumModels.Error.Response){
        let viewModel = AlbumModels.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
