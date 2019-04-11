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
    
    var keyboardHeight: CGFloat = 0.0
    var mainButton: JMButton?
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
        
    @IBAction func textFieldChanged(_ sender: UITextField) {
        switch sender {
        case numberTextField:
            numberTextField.mask("**** **** **** ****")
        case expireTextField:
            expireTextField.mask("**/****")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setupTextFields()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.tableView.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addButton()
    }
    
    @objc
    private func viewTapped() {
        self.view.endEditing(true)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.keyboardHeight = keyboardFrame.cgRectValue.height
            self.updateButtonLayout()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        self.keyboardHeight = 0.0
        self.updateButtonLayout()
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
        self.mainButton = JMButton(title: "Salvar", addIn: self.tableView)
        self.mainButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        self.mainButton?.alpha = 0.0
        self.updateButtonLayout()
    }
    
    @objc
    private func saveButtonTapped() {
        self.performSegue(withIdentifier: "showPrimingCardController", sender: nil)
    }
    
    private func updateButtonLayout() {
        if let button = mainButton, let superview = view.superview {
            button.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -12 - keyboardHeight).isActive = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.mainButton?.alpha = self.allFieldsValid ? 1.0 : 0.0
            }
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
        
        if (numberTextField.text ?? "").isEmpty || (nameTextField.text ?? "").isEmpty || (expireTextField.text ?? "").isEmpty || (cvvTextField.text ?? "").isEmpty {
            valid = false
        }
        
        if (numberTextField.text ?? "").count < 19 && !(numberTextField.text ?? "").isEmpty {
            if showError {
                numberTextField.setError(TextFieldError.invalid("número"), animated: true)
            }
            valid = false
        }
        
        if (nameTextField.text ?? "").count < 3 && !(nameTextField.text ?? "").isEmpty {
            if showError {
                nameTextField.setError(TextFieldError.invalid("nome"), animated: true)
            }
            valid = false
        }
        
        if (expireTextField.text ?? "").count != 7 && !(expireTextField.text ?? "").isEmpty {
            if showError {
                expireTextField.setError(TextFieldError.invalid("data"), animated: true)
            }
            valid = false
        }
        
        if (cvvTextField.text ?? "").count < 3 && !(cvvTextField.text ?? "").isEmpty {
            if showError {
                cvvTextField.setError(TextFieldError.invalid("cvv"), animated: true)
            }
            valid = false
        }
        
        self.allFieldsValid = valid
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
