///
//  UIBarButtonItem+Badge.swift
//  TestPost
//
//  Created by Ruben Duarte on 14/10/21.
//
import UIKit
import SwiftUI

extension UINavigationController {
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
        
    func clearBackground(){
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = .clear
        self.view.backgroundColor = .clear
    }
    
    func setBackground(){
        
        let color: UIColor = #colorLiteral(red: 0.1290824413, green: 0.3538900018, blue: 0.5154382586, alpha: 1)
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.backgroundColor = color
        self.navigationBar.barTintColor = color
        self.view.backgroundColor = color
    }

}
