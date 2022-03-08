//
//  CommentsPresenter.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

protocol CommentsPresentationLogic {
    func presentSomething(response: [CommentsModels.GetComments.Response])
    func presentError(response: CommentsModels.Error.Response)
}

class CommentsPresenter: CommentsPresentationLogic {
    weak var viewController: CommentsDisplayLogic?
  
    // MARK: - Do something
    func presentSomething(response: [CommentsModels.GetComments.Response]) {
        let viewModel = CommentsModels.GetComments.ViewModel(commentsData: response)
        viewController?.displaySomething(viewModel: viewModel, on: .main)
    }
    
    
    //MARK: - Present error
    func presentError(response: CommentsModels.Error.Response){
        let viewModel = CommentsModels.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
