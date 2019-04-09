//
//  UIImageView+Extensions.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import AlamofireImage

extension UIImageView {
    func setImage(with URL: URL) {
        self.af_setImage(withURL: URL, placeholderImage: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false)
    }
}
