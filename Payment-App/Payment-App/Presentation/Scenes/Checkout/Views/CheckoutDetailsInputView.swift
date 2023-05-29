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

    public var creditCardImage: UIImage? {
        didSet {
            creditCardTextField.leftView = UIImageView(image: creditCardImage)
        }
    }

    public var formattedCCText: String? {
        didSet {
            creditCardTextField.text = formattedCCText
        }
    }

    public var formattedExpiryText: String? {
        didSet {
            expiryDateTextField.text = formattedExpiryText
        }
    }

    public var formattedCVVText: String? {
        didSet {
            cvvTextField.text = formattedCVVText
        }
    }

    public var emailErrorVisible: Bool = false {
        didSet {
            if emailErrorVisible {
                UIView.animate(withDuration: 0.2) {
                    self.emailError.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.emailError.alpha = 0
                }
            }
        }
    }

    public var expiryErrorVisible: Bool = false {
        didSet {
            if expiryErrorVisible {
                UIView.animate(withDuration: 0.2) {
                    self.expiryError.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.expiryError.alpha = 0
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubviews()
        self.initializeConstraints()
        self.updateUI()
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
        EmailVStack.addArrangedSubview(emailError)
        ccVSTack.addArrangedSubview(ccLabel)
        ccVSTack.addArrangedSubview(creditCardTextField)
        expiryVStack.addArrangedSubview(expiryDateLabel)
        expiryVStack.addArrangedSubview(expiryDateTextField)
        expiryVStack.addSubview(expiryError)
        cvvVStack.addArrangedSubview(cvvLabel)
        cvvVStack.addArrangedSubview(cvvTextField)
    }

    private func updateUI() {
        EmailVStack.setCustomSpacing(Constants.Spacing.small, after: emailAddressTextField)
        expiryVStack.setCustomSpacing(Constants.Spacing.small, after: expiryError)
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
        constraints.append(expiryError.topAnchor.constraint(equalTo: HStack.bottomAnchor, constant: Constants.Spacing.small))
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
        let HStack = UIStackView()
        HStack.distribution = .fillEqually
        HStack.alignment = .fill
        HStack.spacing = Constants.Spacing.medium
        HStack.axis = .horizontal
        return HStack
    }()

    private lazy var EmailVStack: UIStackView = {
        let VStack = UIStackView()
        VStack.distribution = .fill
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
        VStack.distribution = .fill
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

    private lazy var emailError: UILabel = {
        let error = UILabel()
        error.text = "Invalid Email Format"
        error.textColor = .red
        error.font = .preferredFont(forTextStyle: .footnote, compatibleWith: .init(legibilityWeight: .regular))
        error.alpha = 0
        return error
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

    private lazy var expiryError: UILabel = {
        let error = UILabel()
        error.text = "Invalid Expiry Date"
        error.translatesAutoresizingMaskIntoConstraints = false
        error.textColor = .red
        error.font = .preferredFont(forTextStyle: .footnote, compatibleWith: .init(legibilityWeight: .regular))
        error.alpha = 0
        return error
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
        textfield.keyboardType = .emailAddress
        return textfield
    }()

    public lazy var creditCardTextField: CheckoutTextField = {
        let textfield = CheckoutTextField()
        let leftImageView = UIImageView(image: AssetImage.ccBlank)
        textfield.leftView = leftImageView
        textfield.leftViewMode = .always
        textfield.contentMode = .scaleAspectFit
        textfield.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        textfield.placeholder = "xxxx xxxx xxxx xxxx"
        textfield.keyboardType = .numberPad
        return textfield
    }()

    public lazy var expiryDateTextField: CheckoutTextField = {
        let textfield = CheckoutTextField()
        textfield.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        textfield.placeholder = "mm / yy"
        textfield.keyboardType = .numberPad
        return textfield
    }()

    public lazy var cvvTextField: CheckoutTextField = {
        let textfield = CheckoutTextField()
        textfield.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        textfield.placeholder = "xxx"
        textfield.keyboardType = .numberPad
        return textfield
    }()
}
