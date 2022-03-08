//
//  CommentsEnpoint.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation
import Alamofire

enum CommentsEndpoint {
    case getDashboard(idPost: Int)
}

extension CommentsEndpoint: CMEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getDashboard:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDashboard(let idPost) :
            return "posts/\(idPost)/comments"
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
