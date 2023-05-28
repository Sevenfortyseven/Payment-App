//
//  CheckoutDetailsView.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import UIKit

final class CheckoutDetailsInputView: UIView {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubviews()
        self.initializeConstraints()
    }

    private func addSubviews() {
        self.addSubview(VStack)
        VStack.addArrangedSubview(EmailVStack)
        VStack.addArrangedSubview(ccVSTack)
        VStack.addArrangedSubview(HStack)
        HStack.addArrangedSubview(expiryVStack)
        HStack.addArrangedSubview(cvvVStack)
        EmailVStack.addArrangedSubview(emailAddressLabel)
        EmailVStack.addArrangedSubview(emailAddressTextField)
        ccVSTack.addArrangedSubview(ccLabel)
        ccVSTack.addArrangedSubview(creditCardTextField)
        expiryVStack.addArrangedSubview(expiryDateLabel)
        expiryVStack.addArrangedSubview(expiryDateTextField)
        cvvVStack.addArrangedSubview(cvvLabel)
        cvvVStack.addArrangedSubview(cvvTextField)

    }

    private func initializeConstraints() {
        var constraints: [NSLayoutConstraint] = []
        constraints.append(VStack.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(VStack.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(VStack.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(VStack.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        constraints.append(emailAddressTextField.leadingAnchor.constraint(equalTo: VStack.leadingAnchor))
        constraints.append(emailAddressTextField.trailingAnchor.constraint(equalTo: VStack.trailingAnchor))
        constraints.append(creditCardTextField.leadingAnchor.constraint(equalTo: VStack.leadingAnchor))
        constraints.append(creditCardTextField.trailingAnchor.constraint(equalTo: VStack.trailingAnchor))
        constraints.append(HStack.leadingAnchor.constraint(equalTo: VStack.leadingAnchor))
        constraints.append(HStack.trailingAnchor.constraint(equalTo: VStack.trailingAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Elements

    private lazy var VStack: UIStackView = {
        let VStack = UIStackView()
        VStack.translatesAutoresizingMaskIntoConstraints = false
        VStack.distribution = .fillEqually
        VStack.alignment = .leading
        VStack.spacing = Constants.Spacing.medium
        VStack.axis = .vertical
        return VStack
    }()

    private lazy var HStack: UIStackView = {
        let VStack = UIStackView()
        VStack.distribution = .fillEqually
        VStack.alignment = .fill
        VStack.spacing = Constants.Spacing.medium
        VStack.axis = .horizontal
        return VStack
    }()

    private lazy var EmailVStack: UIStackView = {
        let VStack = UIStackView()
        VStack.distribution = .fillEqually
        VStack.alignment = .fill
        VStack.spacing = Constants.Spacing.small
        VStack.axis = .vertical
        return VStack
    }()

    private lazy var ccVSTack: UIStackView = {
        let VStack = UIStackView()
        VStack.distribution = .fillEqually
        VStack.alignment = .fill
        VStack.spacing = Constants.Spacing.small
        VStack.axis = .vertical
        return VStack
    }()

    private lazy var expiryVStack: UIStackView = {
        let VStack = UIStackView()
        VStack.distribution = .fillEqually
        VStack.alignment = .fill
        VStack.spacing = Constants.Spacing.small
        VStack.axis = .vertical
        return VStack
    }()

    private lazy var cvvVStack: UIStackView = {
        let VStack = UIStackView()
        VStack.distribution = .fillEqually
        VStack.alignment = .fill
        VStack.spacing = Constants.Spacing.small
        VStack.axis = .vertical
        return VStack
    }()

    private lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Address"
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        return label
    }()

    private lazy var ccLabel: UILabel = {
        let label = UILabel()
        label.text = "Credit Card Number"
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        return label
    }()

    private lazy var expiryDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Expiry Date"
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        return label
    }()

    private lazy var cvvLabel: UILabel = {
        let label = UILabel()
        label.text = "CVV"
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        return label
    }()

    public lazy var emailAddressTextField: CheckoutTextField = {
        let textfield = CheckoutTextField()
        textfield.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        textfield.placeholder = "Enter Your Email"
        return textfield
    }()

    public lazy var creditCardTextField: CheckoutTextField = {
        let textfield = CheckoutTextField()
        textfield.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        textfield.placeholder = "xxxx xxxx xxxx xxxx"
        return textfield
    }()

    public lazy var expiryDateTextField: CheckoutTextField = {
        let textfield = CheckoutTextField()
        textfield.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        textfield.placeholder = "mm / yy"
        return textfield
    }()

    public lazy var cvvTextField: CheckoutTextField = {
        let textfield = CheckoutTextField()
        textfield.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        textfield.placeholder = "xxx"
        return textfield
    }()
}
