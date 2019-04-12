//
//  CreditCardTableViewController.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import MaterialTextField
import UIKit

class CreditCardTableViewController: UITableViewController {
    
    // MARK: - Variables
    
    var viewModel: TransactionViewModel?
    var buttonBottomConstraint: NSLayoutConstraint?
    
    var keyboardHeight: CGFloat = 0.0 {
        didSet {
            self.updateButtonLayout()
        }
    }
    
    var mainButton: JMButton
    var oldValue = false
    var allFieldsValid: Bool = false {
        didSet {
            if oldValue != allFieldsValid {
                self.oldValue = allFieldsValid
                self.updateButtonLayout()
            }
        }
    }
    
    // MARK: - Outlets

    @IBOutlet private weak var numberTextField: MFTextField!
    @IBOutlet private weak var nameTextField: MFTextField!
    @IBOutlet private weak var expireTextField: MFTextField!
    @IBOutlet private weak var cvvTextField: MFTextField!
    
    // MARK: - Actions
        
    @IBAction private func textFieldChanged(_ sender: UITextField) {
        switch sender {
        case numberTextField:
            numberTextField.mask("**** **** **** ****")
        case expireTextField:
            expireTextField.mask("**/**")
        case cvvTextField:
            cvvTextField.mask("***")
        default:
            break
        }
        
        if let mfTextField = sender as? MFTextField {
            self.verifyField(mfTextField, showError: false)
        }
    }
    
    // MARK: - Life Cycle
    
    required init?(coder aDecoder: NSCoder) {
        self.mainButton = JMButton(title: "Salvar")
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextFields()
        
        self.setupTap()
    }
    
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.tableView.addGestureRecognizer(tap)
    }
    
    private func setupKeyboard() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
        self.mainButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupKeyboard()
        self.addButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mainButton.alpha = 0.0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func viewTapped() {
        self.view.endEditing(true)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.keyboardHeight = keyboardFrame.cgRectValue.height
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        self.keyboardHeight = 0.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    // MARK: - Setups
    
    private func setupTextFields() {
        numberTextField.placeholderFont = UIFont.systemFont(ofSize: 16)
        nameTextField.placeholderFont = UIFont.systemFont(ofSize: 16)
        expireTextField.placeholderFont = UIFont.systemFont(ofSize: 16)
        cvvTextField.placeholderFont = UIFont.systemFont(ofSize: 16)
        
        numberTextField.delegate = self
        nameTextField.delegate = self
        expireTextField.delegate = self
        cvvTextField.delegate = self
    }
    
    private func addButton() {
        self.mainButton.addIn(self.tableView)
//        if self.mainButton == nil {
//            self.mainButton = JMButton(title: "Salvar", addIn: self.tableView)
            self.mainButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            self.mainButton.alpha = 0.0
//        }
        if let superview = view.superview {
            self.buttonBottomConstraint = mainButton.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -12)
            self.buttonBottomConstraint?.isActive = true
        }
        
        self.updateButtonLayout()
        
    }
    
    @objc
    private func saveButtonTapped() {
        self.view.endEditing(true)
        
        self.viewModel?.cardNumber = self.numberTextField.text
        self.viewModel?.cardName = self.nameTextField.text
        self.viewModel?.expiryDate = self.expireTextField.text
        self.viewModel?.cvv = self.cvvTextField.text
        
        self.performSegue(withIdentifier: "showPrimingCardController", sender: nil)
    }
    
    private func updateButtonLayout() {
            buttonBottomConstraint?.constant = -12 - keyboardHeight
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.mainButton.alpha = self.allFieldsValid ? 1.0 : 0.0
            }
    }
    
    private func verifyField(_ textField: MFTextField, showError: Bool = true) {
        guard let text = textField.text else { return }
        
        if text.isEmpty {
            if showError {
                textField.setError(TextFieldError.empty, animated: true)
            }
        } else {
            self.verifyFields(showError: showError)
        }
    }
    
    func verifyFields(showError: Bool) {
        var valid = true
        
        if numberTextField.text.isNullOrEmpty ||
           nameTextField.text.isNullOrEmpty ||
           expireTextField.text.isNullOrEmpty ||
           cvvTextField.text.isNullOrEmpty {
            valid = false
        }
        
        if (numberTextField.text ?? "").count < 19 && !(numberTextField.text ?? "").isEmpty {
            if showError {
                numberTextField.setError(TextFieldError.invalid("número inválido"), animated: true)
            }
            valid = false
        }
        
        if (nameTextField.text ?? "").count < 3 && !(nameTextField.text ?? "").isEmpty {
            if showError {
                nameTextField.setError(TextFieldError.invalid("nome inválido"), animated: true)
            }
            valid = false
        }
        
        if (expireTextField.text ?? "").count != 5 && !(expireTextField.text ?? "").isEmpty {
            if showError {
                expireTextField.setError(TextFieldError.invalid("data inválida"), animated: true)
            }
            valid = false
        }
        
        if (cvvTextField.text ?? "").count < 3 && !(cvvTextField.text ?? "").isEmpty {
            if showError {
                cvvTextField.setError(TextFieldError.invalid("cvv inválido"), animated: true)
            }
            valid = false
        }
        
        self.allFieldsValid = valid
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TransferValueViewController {
            destination.viewModel = self.viewModel
        }
    }
}

extension CreditCardTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let mfTextField = textField as? MFTextField {
            mfTextField.setError(nil, animated: false)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let mfTextField = textField as? MFTextField {
            self.verifyField(mfTextField)
        }
    }
}

extension Optional where Wrapped == String {
    var isNullOrEmpty: Bool {
        return (self ?? "").isEmpty
    }
}
