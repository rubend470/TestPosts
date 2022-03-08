//
//  CommentsRouter.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation
import UIKit

@objc protocol CommentsRoutingLogic {
}

protocol CommentsDataPassing {
    var dataStore: CommentsDataStore? { get }
}

class CommentsRouter: NSObject, CommentsRoutingLogic, CommentsDataPassing {
    weak var viewController: CommentsViewController?
    var dataStore: CommentsDataStore?
  
}
