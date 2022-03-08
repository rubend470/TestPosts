//
//  CommentsApi.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

protocol CommentsServiceProtocol {
    func getComments(request: CommentsModels.GetComments.Request, completion: @escaping (Result<[CommentsModels.GetComments.Response], CommentsError>) -> Void)
}

class CommentsAPI: CommentsServiceProtocol {
        
    func getComments(request: CommentsModels.GetComments.Request, completion: @escaping (Result<[CommentsModels.GetComments.Response], CommentsError>) -> Void) {
        NetworkService.share.request(endpoint: CommentsEndpoint.getDashboard(idPost: request.idPost)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([CommentsModels.GetComments.Response].self, from: data!)
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
