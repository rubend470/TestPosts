//
//  HomeEnpoint.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation
import Alamofire

enum DashboardEndpoint {
    case getDashboard
}

extension DashboardEndpoint: CMEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getDashboard:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDashboard:
            return "posts"
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
