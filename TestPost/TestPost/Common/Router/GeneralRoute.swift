//
//  GeneralRoute.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case main
//    case home
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .main:
            return HomeViewController()
//        case .home:
//            return HomeViewController()
       
        }
    }
}
