//
//  CustomSearchTextField.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

protocol CustomSearchBarDelegate {
    func customSearchDidChange(_ customSearch: CustomSearchBarView, text: String)
    func customSearchDidReturn(_ customSearch: CustomSearchBarView, text: String)
}

class CustomSearchBarView: UIView {
    
    private let textfield: UITextField
    var delegate: CustomSearchBarDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        self.textfield = UITextField(frame: CGRect.zero)
        super.init(coder: aDecoder)
    }
    
    private func setupLayout() {
        self.backgroundColor = .clear
        self.setupTextField()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.setupLayout()
    }
    
    private func setupTextField() {
        textfield.frame = CGRect(x: 16, y: 0, width: self.frame.width - 32, height: self.frame.height)
        textfield.backgroundColor = UIColor(hex: "#2B2C2F")
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = self.frame.height / 2.0
        textfield.textColor = UIColor.white
        
        self.addSubview(textfield)
        
        textfield.placeholder = "A quem você deseja pagar?"
        textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: "#ACB1BD"),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "icon-search"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 16.0 + 42.0, height: 16.0)
        textfield.leftView = imageView
        textfield.leftViewMode = .always
        textfield.leftView?.tintColor = UIColor(hex: "#ACB1BD")
        textfield.layer.borderWidth = 1.0
        textfield.delegate = self
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10 + 40, height: 10))
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "icon-close.png"), for: .normal)
        textfield.rightView = button
        textfield.rightViewMode = .whileEditing
        textfield.layer.borderColor = UIColor(hex: "#2B2C2F").cgColor
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc
    private func clearTapped() {
        self.textfield.text = ""
        self.endEditing(true)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        self.delegate?.customSearchDidChange(self, text: textField.text ?? "")
    }
    
    private func setSelected(_ value: Bool) {
        textfield.leftView?.tintColor = value ? UIColor.white : UIColor(hex: "#ACB1BD")
        textfield.layer.borderColor = value ? UIColor.white.cgColor : UIColor(hex: "#2B2C2F").cgColor
    }
}

extension CustomSearchBarView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.setSelected(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.setSelected(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.customSearchDidReturn(self, text: textField.text ?? "")
        return true
    }

}
