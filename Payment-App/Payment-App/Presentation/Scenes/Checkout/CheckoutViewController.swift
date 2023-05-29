//
//  ViewController.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import Combine
import UIKit

final class CheckoutViewController: UIViewController {

    // MARK: - Initialization

    var viewModel: CheckoutViewModel
    var checkoutDetailsInputView: CheckoutDetailsInputView = CheckoutDetailsInputView()
    var checkoutDetailsFooterView: CheckoutDetailsFooterView = CheckoutDetailsFooterView()
    var checkoutButton: CheckoutButton = CheckoutButton()
    var cancellables = Set<AnyCancellable>()

    public init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        initizeConstraints()
        updateUI()
        initPublishers()
    }

    private func updateUI() {
        self.view.backgroundColor = .white
        self.title = "Payment Details"
    }

    private func addSubviews() {
        self.view.addSubview(checkoutDetailsInputView)
        self.view.addSubview(checkoutDetailsFooterView)
        self.view.addSubview(checkoutButton)
    }

    private func initPublishers() {
        checkoutDetailsInputView.emailAddressTextField.publisher(for: \.text)
            .compactMap { $0 }
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] emailText in
                guard let self else { return }
                self.viewModel.emailInfo.text = emailText
                self.checkoutDetailsInputView.emailErrorVisible = self.viewModel.isInvalidEmail(emailText)
            })
            .store(in: &cancellables)
        checkoutDetailsInputView.creditCardTextField.textPublisher()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] ccText in
                self?.viewModel.ccInfo.text = ccText
                self?.checkoutDetailsInputView.creditCardImage = self?.viewModel.creditCardImage
                self?.checkoutDetailsInputView.formattedCCText = self?.viewModel.formatCreditCardText(ccText)
            })
            .store(in: &cancellables)
        checkoutDetailsInputView.cvvTextField.textPublisher()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] cvvText in
                self?.viewModel.cvvInfo.text = cvvText
                self?.checkoutDetailsInputView.formattedCVVText = self?.viewModel.formatCVVText(cvvText)
            })
            .store(in: &cancellables)

        let emailTextDidChangePublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: checkoutDetailsInputView.emailAddressTextField)
            .compactMap { ($0.object as? UITextField)?.text }

        let emailTextDidEndEditingPublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: checkoutDetailsInputView.emailAddressTextField)
            .compactMap { ($0.object as? UITextField)?.text }

        let expiryTextDidChangePublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: checkoutDetailsInputView.expiryDateTextField)
            .compactMap { ($0.object as? UITextField)?.text }

        let expiryTextDidEndEditingPublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: checkoutDetailsInputView.expiryDateTextField)
            .compactMap { ($0.object as? UITextField)?.text }

        emailTextDidChangePublisher
            .sink(receiveValue: { [weak self] emailText in
                guard let self else { return }
                self.viewModel.emailInfo.text = emailText
            })
            .store(in: &cancellables)

        emailTextDidEndEditingPublisher
            .sink(receiveValue: { [weak self] emailText in
                guard let self else { return }
                self.checkoutDetailsInputView.emailErrorVisible = self.viewModel.isInvalidEmail(emailText)
            })
            .store(in: &cancellables)

        expiryTextDidChangePublisher
            .sink(receiveValue: { [weak self] expiryText in
                self?.viewModel.expiryInfo.text = expiryText
                self?.checkoutDetailsInputView.formattedExpiryText = self?.viewModel.formatExpiryDateText(expiryText)
            })
            .store(in: &cancellables)

        expiryTextDidEndEditingPublisher
            .sink(receiveValue: { [weak self] expiryText in
                guard let self else { return }
                self.checkoutDetailsInputView.expiryErrorVisible = self.viewModel.isInvalidExpiryDate(expiryText)
            })
            .store(in: &cancellables)

        viewModel.isValidPublisher
            .sink { [weak self] isValid in
                self?.checkoutButton.shouldEnablePayment = isValid
            }
            .store(in: &cancellables)
    }
}


extension CheckoutViewController {
    // MARK: - Constraints

    private func initizeConstraints() {
        var constraints: [NSLayoutConstraint] = []
        constraints.append(checkoutDetailsInputView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.Offset.top))
        constraints.append(checkoutDetailsInputView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.Offset.leading))
        constraints.append(checkoutDetailsInputView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.Offset.trailing))
        constraints.append(checkoutDetailsFooterView.topAnchor.constraint(equalTo: checkoutDetailsInputView.bottomAnchor, constant: Constants.Spacing.large))
        constraints.append(checkoutDetailsFooterView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.Offset.leading))
        constraints.append(checkoutDetailsFooterView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.Offset.trailing))
        constraints.append(checkoutButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.Offset.trailing))
        constraints.append(checkoutButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.Offset.leading))
        constraints.append(checkoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0))
        NSLayoutConstraint.activate(constraints)

    }
}
