//
//  CheckoutDetailsFooterView.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import UIKit

class CheckoutDetailsFooterView: UIView {

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
        VStack.addArrangedSubview(subtotalHStack)
        VStack.addArrangedSubview(feeHStack)
        VStack.addArrangedSubview(dividerView)
        VStack.addArrangedSubview(totalAmountHStack)
        subtotalHStack.addArrangedSubview(subtotalLabel)
        subtotalHStack.addArrangedSubview(subtotalAmount)
        feeHStack.addArrangedSubview(feeLabel)
        feeHStack.addArrangedSubview(feeAmount)
        totalAmountHStack.addArrangedSubview(totalAmountLabel)
        totalAmountHStack.addArrangedSubview(totalAmount)
    }

    private func initializeConstraints() {
        var constraints: [NSLayoutConstraint] = []
        constraints.append(VStack.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(VStack.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(VStack.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(VStack.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        constraints.append(dividerView.leadingAnchor.constraint(equalTo: VStack.leadingAnchor))
        constraints.append(dividerView.trailingAnchor.constraint(equalTo: VStack.trailingAnchor))
        constraints.append(dividerView.heightAnchor.constraint(equalToConstant: Constants.Height.divider))
        constraints.append(subtotalHStack.trailingAnchor.constraint(equalTo: VStack.trailingAnchor))
        constraints.append(subtotalHStack.leadingAnchor.constraint(equalTo: VStack.leadingAnchor))
        constraints.append(feeHStack.trailingAnchor.constraint(equalTo: VStack.trailingAnchor))
        constraints.append(feeHStack.leadingAnchor.constraint(equalTo: VStack.leadingAnchor))
        constraints.append(totalAmountHStack.trailingAnchor.constraint(equalTo: VStack.trailingAnchor))
        constraints.append(totalAmountHStack.leadingAnchor.constraint(equalTo: VStack.leadingAnchor))
        constraints.append(subtotalAmount.trailingAnchor.constraint(equalTo: subtotalHStack.trailingAnchor))
        constraints.append(feeAmount.trailingAnchor.constraint(equalTo: feeHStack.trailingAnchor))
        constraints.append(totalAmount.trailingAnchor.constraint(equalTo: totalAmountHStack.trailingAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Elements

    private lazy var VStack: UIStackView = {
        let VStack = UIStackView()
        VStack.translatesAutoresizingMaskIntoConstraints = false
        VStack.distribution = .fill
        VStack.alignment = .leading
        VStack.spacing = Constants.Spacing.medium
        VStack.axis = .vertical
        return VStack
    }()

    private lazy var subtotalHStack: UIStackView = {
        let HStack = UIStackView()
        HStack.distribution = .equalSpacing
        HStack.alignment = .fill
        HStack.spacing = Constants.Spacing.medium
        HStack.axis = .horizontal
        return HStack
    }()

    private lazy var feeHStack: UIStackView = {
        let HStack = UIStackView()
        HStack.distribution = .equalSpacing
        HStack.alignment = .fill
        HStack.spacing = Constants.Spacing.medium
        HStack.axis = .horizontal
        return HStack
    }()

    private lazy var totalAmountHStack: UIStackView = {
        let HStack = UIStackView()
        HStack.distribution = .equalSpacing
        HStack.alignment = .fill
        HStack.spacing = Constants.Spacing.medium
        HStack.axis = .horizontal
        return HStack
    }()

    private lazy var subtotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtotal"
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        label.textColor = .gray
        return label
    }()

    private lazy var feeLabel: UILabel = {
        let label = UILabel()
        label.text = "Platform Fee"
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        label.textColor = .gray
        return label
    }()

    private lazy var totalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Amount"
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        label.textColor = .gray
        return label
    }()

    private lazy var subtotalAmount: UILabel = {
        let label = UILabel()
        label.text = "$96"
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .black
        return label
    }()

    private lazy var feeAmount: UILabel = {
        let label = UILabel()
        label.text = "$4"
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .black
        return label
    }()

    private lazy var totalAmount: UILabel = {
        let label = UILabel()
        label.text = "$100"
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .black
        return label
    }()

    private lazy var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .gray
        return dividerView
    }()
}
