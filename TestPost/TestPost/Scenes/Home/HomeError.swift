//
//  HomeError.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation

enum HomeError: Error, CustomStringConvertible {
    case request
    case network(Error)
    case parse(Error)
    case server(description: String)
    case localData(Error)
    
    var description: String {
        switch self {
        case .network(let error), .parse(let error), .localData(let error):
            return error.localizedDescription
        case .request:
            return "Error request"
        case .server(let description):
            return description
        }
    }
}
