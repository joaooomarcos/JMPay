//
//  ReceiptViewController.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {
    
    // MARK: - Variables
    
    var viewModel: ReceiptViewModel?
    
    // MARK: - Outlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var swipeView: UIView!
    @IBOutlet private weak var userImage: JMImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var transactionLabel: UILabel!
    @IBOutlet private weak var cardLabel: UILabel!
    @IBOutlet private weak var cardValueLabel: UILabel!
    @IBOutlet private weak var totalValueLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        self.swipeView.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupForAnimation()
        self.setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateShow()
    }
    
    private func setupForAnimation() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
    }
    
    private func animateShow() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = CGAffineTransform.identity
        }
    }
    
    private func setupLayout() {
        guard let viewModel = viewModel else { return }
        self.userImage.setImage(with: viewModel.contactImage)
        self.usernameLabel.text = viewModel.contactName
        self.dateLabel.text = viewModel.transactionDate
        self.transactionLabel.text = viewModel.transactionId
        self.cardLabel.text = viewModel.cardName
        self.cardValueLabel.text = viewModel.value
        self.totalValueLabel.text = viewModel.value
    }
    
    var initialTouchPoint = CGPoint(x: 0, y: 0)
    
    @objc
    private func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        let size = self.containerView.frame.size
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.containerView.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y + 92.0, width: size.width, height: size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 180 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.containerView.frame = CGRect(x: 0, y: self.view.frame.height, width: size.width, height: size.height)
                }, completion: { _ in
                    self.dismiss(animated: false, completion: nil)
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    let size = self.containerView.frame.size
                    self.containerView.frame = CGRect(x: 0, y: 92, width: size.width, height: size.height)
                })
            }
        }
    }
}
