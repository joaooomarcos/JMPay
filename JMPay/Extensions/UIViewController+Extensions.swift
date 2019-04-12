//
//  UIViewController+Extensions.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavigation(preferLarge: Bool = false, bartintColor: UIColor = .clear) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = preferLarge
        self.navigationController?.navigationBar.backgroundColor = bartintColor
    }
    
    func showAlert(title: String = "", message: String = "", firstButtonTitle: String = "OK", secondButtonTitle: String? = nil, firstButtonAction: ((UIAlertAction) -> Void)? = nil, secondButtonAction: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstButtonTitle, style: .cancel, handler: firstButtonAction)
        alert.addAction(firstAction)
        
        if let secondTitle = secondButtonTitle {
            let secondAction = UIAlertAction(title: secondTitle, style: .default, handler: firstButtonAction)
            alert.addAction(secondAction)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
