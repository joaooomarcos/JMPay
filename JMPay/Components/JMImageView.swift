//
//  JMImageView.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

@IBDesignable
class JMImageView: UIImageView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var clipping: Bool {
        get {
            return clipsToBounds
        }
        set {
            clipsToBounds = newValue
        }
    }
    
    @IBInspectable
    var roundCircle: Bool {
        get {
            return clipsToBounds && layer.cornerRadius == layer.frame.height / 2.0
        }
        set {
            clipsToBounds = newValue ? true : clipsToBounds
            layer.cornerRadius = newValue ? layer.frame.height / 2.0 : 0.0
        }
    }
}
