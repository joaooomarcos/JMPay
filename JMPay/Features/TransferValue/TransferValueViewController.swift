//
//  TransferValueViewController.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class TransferValueViewController: UIViewController {
    
    // MARK: - Variables
    
    var viewModel: TransactionViewModel?
    
    // MARK: - Constants
    
    private var defaultMargin: CGFloat = 12.0
    
    // MARK: - Outlets

    @IBOutlet weak var valueStackView: UIStackView!
    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userImage: JMImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Actions
    
    @IBAction private func editButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func payButtonTapped() {
        self.animateLoading(show: true)
        self.viewModel?.doTransfer(value: self.valueTextField.text ?? "", completion: { receipt, _ in
            self.animateLoading(show: false)
            if let receipt = receipt {
                if let controller = self.navigationController?.viewControllers.first as? ContactsViewController {
                    controller.receipt = receipt
                }
                self.navigationController?.popToRootViewController(animated: false)
            } else {
                self.showAlert(title: "Erro", message: "Erro ao processar o pagamento")
            }
        })
    }
    
    private func animateLoading(show: Bool) {
        self.view.endEditing(true)
        self.payButton.isEnabled = !show
        if show {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.valueStackView.alpha = show ? 0.0 : 1.0
            self.cardStackView.alpha = show ? 0.0 : 1.0
        }, completion: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tap)
        self.setupLayout()
    }
    
    @objc
    private func viewTapped() {
        self.view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.updateButtonLayout(keyboardHeight: keyboardFrame.cgRectValue.height)
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        self.updateButtonLayout()
    }
    
    private func updateButtonLayout(keyboardHeight: CGFloat = 0.0) {
        let safeArea = keyboardHeight != 0.0 ? self.view.safeAreaInsets.bottom : 0.0
        self.buttonBottomConstraint.constant = keyboardHeight + defaultMargin - safeArea
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupTextField()
    }
    
    private func setupTextField() {
        self.valueTextField.becomeFirstResponder()
        self.valueTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    private func setupLayout() {
        self.activityIndicator.stopAnimating()
        guard let viewModel = viewModel else { return }
        self.usernameLabel.text = viewModel.contact?.username ?? ""
        self.creditCardLabel.text = viewModel.cardNumber ?? ""
        self.userImage.setImage(with: viewModel.contact?.image)
    }
    
    @objc
    private func textFieldChanged(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
            textField.textColor = textField.text != "0,00" ? .mainTint : UIColor.white.withAlphaComponent(0.4)
            symbolLabel.textColor = textField.text != "0,00" ? .mainTint : UIColor.white.withAlphaComponent(0.4)
            self.payButton.isEnabled = textField.text != "0,00"
        }
    }
}

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale.br
        
        var amountWithPrefix = self
        
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let options = NSRegularExpression.MatchingOptions(rawValue: 0)
            let range = NSRange(location: 0, length: self.count)
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: options, range: range, withTemplate: "")
        } catch {
            return "0,00"
        }
        
        let double = (amountWithPrefix as NSString).doubleValue
        let number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
            return "0,00"
        }
        
        return formatter.string(from: number) ?? "0,00"
    }
}

extension Locale {
    static let br = Locale(identifier: "pt_BR")
}
