//
//  JMButton.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class JMButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }
    
    private func setupLayout() {
        self.updateLayout()
        self.tintColor = UIColor.white
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    override var isEnabled: Bool {
        didSet {
            self.updateLayout()
        }
    }
    
    private func updateLayout() {
        self.backgroundColor = isEnabled ? UIApplication.shared.keyWindow?.tintColor : UIColor(hex: "#8F929D")
    }
}
