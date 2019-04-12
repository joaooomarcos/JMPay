//
//  UIImageView+Extensions.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import AlamofireImage

extension UIImageView {
    func setImage(with string: String?) {
        if let str = string, !str.isEmpty, let url = URL(string: str) {
            self.af_setImage(withURL: url, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false)
        }
    }
}
