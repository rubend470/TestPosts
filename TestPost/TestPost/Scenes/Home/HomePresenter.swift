//
//  HomePresenter.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation

protocol HomePresentationLogic {
    func presentSomething(response: [HomeModels.GetHome.Response])
    func presentError(response: HomeModels.Error.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
  
    // MARK: - Do something
    func presentSomething(response: [HomeModels.GetHome.Response]) {
        let viewModel = HomeModels.GetHome.ViewModel(HomeData: response)
        viewController?.displaySomething(viewModel: viewModel, on: .main)
    }
    
    
    //MARK: - Present error
    func presentError(response: HomeModels.Error.Response){
        let viewModel = HomeModels.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
