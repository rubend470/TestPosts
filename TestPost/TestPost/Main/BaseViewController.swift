//
//  BaseViewController.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import UIKit

class BaseViewController: UIViewController {
    var loadingVC: LoadingIndicatorViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.clearBackground()
    }
    
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    func setupBackButton(title : String) {
            let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(self.backButtonClickedDismiss(sender:)))
            
            let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
            let labelText = UILabel()
            
            labelText.text = title.uppercased()
            labelText.font = UIFont(name: "Roboto-Medium", size: 14)
            labelText.textAlignment = .center
            
            self.navigationItem.leftBarButtonItem  = backButtonItem
            
            labelText.frame = CGRect(x: 0, y: 0, width: 300, height: 40)

            titleView.addSubview(labelText)
            titleView.backgroundColor = .clear
            self.navigationItem.titleView = titleView
            self.navigationItem.leftBarButtonItem?.tintColor = .white
            labelText.textColor = .white
            navigationController?.setBackground()
            
        }
    
    func settingsNavBar(title: String) {
        let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: ""),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(self.backButtonClickedDismiss(sender:)))
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        let labelText = UILabel()
        
        labelText.text = title.uppercased()
        labelText.font = UIFont(name: "Roboto-Medium", size: 14)
        labelText.textAlignment = .center
        
        self.navigationItem.leftBarButtonItem  = backButtonItem
        
        labelText.frame = CGRect(x: 0, y: 0, width: 300, height: 40)

        titleView.addSubview(labelText)
        titleView.backgroundColor = .clear
        self.navigationItem.titleView = titleView
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        labelText.textColor = .white
        navigationController?.setBackground()
//        navigationController?.setBackground()
    }

    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    func displaySimpleAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Loading View
extension BaseViewController {
    func showLoading() {
        loadingVC = LoadingIndicatorViewController()
        add(loadingVC!)
        loadingVC?.view.frame = view.bounds
    }

    func showLoading(inside wiew: UIView) {
        loadingVC = LoadingIndicatorViewController()
        add(child: loadingVC!, container: wiew)
        loadingVC?.view.frame = wiew.bounds
    }

    func hideLoading() {
        loadingVC?.remove()
        loadingVC = nil
    }
}
