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

    @IBOutlet private weak var valueStackView: UIStackView!
    @IBOutlet private weak var cardStackView: UIStackView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var userImage: JMImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var creditCardLabel: UILabel!
    @IBOutlet private weak var payButton: UIButton!
    @IBOutlet private weak var buttonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Actions
    
    @IBAction private func editButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func payButtonTapped() {
        self.payAction()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTap()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupKeyboard()
        self.setupTextField()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setups
    
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tap)
    }
    
    private func setupKeyboard() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTextField() {
        self.valueTextField.becomeFirstResponder()
        self.valueTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    // MARK: - Selectors
    
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
    
    @objc
    private func textFieldChanged(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
            textField.textColor = textField.text != "0,00" ? .mainTint : UIColor.white.withAlphaComponent(0.4)
            symbolLabel.textColor = textField.text != "0,00" ? .mainTint : UIColor.white.withAlphaComponent(0.4)
            self.payButton.isEnabled = textField.text != "0,00"
        }
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        self.activityIndicator.stopAnimating()
        guard let viewModel = viewModel else { return }
        self.usernameLabel.text = viewModel.contact?.username ?? ""
        self.creditCardLabel.text = viewModel.cardNumber ?? ""
        self.userImage.setImage(with: viewModel.contact?.image)
    }
    
    private func updateButtonLayout(keyboardHeight: CGFloat = 0.0) {
        let safeArea = keyboardHeight != 0.0 ? self.view.safeAreaInsets.bottom : 0.0
        self.buttonBottomConstraint.constant = keyboardHeight + defaultMargin - safeArea
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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
    
    // MARK: - Main action
    
    private func payAction() {
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
}
