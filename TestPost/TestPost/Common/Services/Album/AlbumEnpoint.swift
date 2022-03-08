//
//  AlbumEnpoint.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation
import Alamofire

enum AlbumEndpoint {
    case getDashboard(idPost: Int)
}

extension AlbumEndpoint: CMEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getDashboard:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDashboard(let idPost) :
            return "posts/\(idPost)/photos"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getDashboard:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getDashboard:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
