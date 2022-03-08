//
//  HomeApi.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation

protocol HomeServiceProtocol {
    func getHome(request: HomeModels.GetHome.Request, completion: @escaping (Result<[HomeModels.GetHome.Response], HomeError>) -> Void)
}

class HomeAPI: HomeServiceProtocol {
    
    func getHome(request: HomeModels.GetHome.Request, completion: @escaping (Result<[HomeModels.GetHome.Response], HomeError>) -> Void) {
        NetworkService.share.request(endpoint: DashboardEndpoint.getDashboard) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([HomeModels.GetHome.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
