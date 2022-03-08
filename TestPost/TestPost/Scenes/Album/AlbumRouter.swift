//
//  AlbumRouter.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation
import UIKit

@objc protocol AlbumRoutingLogic {
}

protocol AlbumDataPassing {
    var dataStore: AlbumDataStore? { get }
}

class AlbumRouter: NSObject, AlbumRoutingLogic, AlbumDataPassing {
    weak var viewController: AlbumViewController?
    var dataStore: AlbumDataStore?
  
}
