//
//  JMButton.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class JMButton: UIButton {
    
    // MARK: - Constants
    
    private static let VIEW_MARGIN: CGFloat = 12.0
    private static let HEIGHT: CGFloat = 48.0
    
    // MARK: - Init
    
    convenience init(title: String, addIn view: UIView) {
        self.init(frame: CGRect.zero)
        view.addSubview(self)
        self.setupConstraints(view: view)
        self.setTitle(title, for: .normal)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }
    
    // MARK: - Override
    
    override var isEnabled: Bool {
        didSet {
            self.updateLayout()
        }
    }
    
    // MARK: - Layout
    
    private func setupConstraints(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: view.frame.width - 2 * JMButton.VIEW_MARGIN).isActive = true
        self.heightAnchor.constraint(equalToConstant: JMButton.HEIGHT).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: JMButton.VIEW_MARGIN).isActive = true
    }
    
    private func setupLayout() {
        self.updateLayout()
        self.tintColor = UIColor.white
        self.layer.cornerRadius = JMButton.HEIGHT / 2.0
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    private func updateLayout() {
        self.backgroundColor = isEnabled ? UIApplication.shared.keyWindow?.tintColor : UIColor(hex: "#8F929D")
    }
}
