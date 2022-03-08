//
//  AlbumApi.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

protocol AlbumServiceProtocol {
    func getAlbum(request: AlbumModels.GetAlbum.Request, completion: @escaping (Result<[AlbumModels.GetAlbum.Response], AlbumError>) -> Void)
}

class AlbumAPI: AlbumServiceProtocol {
    
    func getAlbum(request: AlbumModels.GetAlbum.Request, completion: @escaping (Result<[AlbumModels.GetAlbum.Response], AlbumError>) -> Void) {
        NetworkService.share.request(endpoint: AlbumEndpoint.getDashboard(idPost: request.idPost)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([AlbumModels.GetAlbum.Response].self, from: data!)

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
