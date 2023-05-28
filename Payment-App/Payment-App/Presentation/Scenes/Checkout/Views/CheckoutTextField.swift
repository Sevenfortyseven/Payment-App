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
        self.heightAnchor.constraint(equalToConstant: Constants.Height.checkoutTextField).isActive = true
    }
}
