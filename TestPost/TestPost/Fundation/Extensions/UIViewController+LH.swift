//
//  UIViewController+FW.swift
//  TestPost
//
//  Created by Ruben Duarte on 14/10/21.
//

import UIKit

extension UIViewController {
    
    func validate(_ textfields: UITextField...) -> Bool {
        for textField in textfields {
            guard let text = textField.text else { return false }
            
            if text.isEmpty {
                return false
            }
        }
        
        return true
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
