//
//  CheckoutTextField.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import UIKit

final class CheckoutTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.borderStyle = .roundedRect
        self.textColor = .darkGray
        self.backgroundColor = .systemBackground
        self.heightAnchor.constraint(equalToConstant: Constants.Height.checkoutTextField).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        setKeyboardToolbarItem()
    }

    private func setKeyboardToolbarItem() {
        let doneButtonToolbar = UIToolbar()
        doneButtonToolbar.tintColor = .black
        doneButtonToolbar.barTintColor = .systemGray6
        doneButtonToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        doneButtonToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = doneButtonToolbar
    }

    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
