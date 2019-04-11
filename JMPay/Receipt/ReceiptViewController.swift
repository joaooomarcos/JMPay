//
//  ReceiptViewController.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var swipeView: UIView!
    @IBOutlet private weak var userImage: JMImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var transactionLabel: UILabel!
    @IBOutlet private weak var cardLabel: UILabel!
    @IBOutlet private weak var cardValueLabel: UILabel!
    @IBOutlet private weak var totalValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        self.swipeView.addGestureRecognizer(panGesture)
    }
    
    // define a variable to store initial touch position
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    @objc
    private func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.containerView.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y + 92.0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 180 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.containerView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
                }) { _ in
                    self.dismiss(animated: false, completion: nil)
                }
                
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.containerView.frame = CGRect(x: 0, y: 92, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
                })
            }
        }
    }

}


