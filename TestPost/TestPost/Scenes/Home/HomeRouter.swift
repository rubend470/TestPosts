//
//  HomeRouter.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation
import UIKit

@objc protocol HomeRoutingLogic {
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
  
}
