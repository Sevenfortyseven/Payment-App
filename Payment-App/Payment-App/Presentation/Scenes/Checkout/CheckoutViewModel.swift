//
//  PaymentViewModel.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import UIKit
import Combine

final class CheckoutViewModel {

    var emailInfo: TextFieldInfo
    var ccInfo: TextFieldInfo
    var expiryInfo: TextFieldInfo
    var cvvInfo: TextFieldInfo

    init(
        emailInfo: TextFieldInfo = TextFieldInfo(text: ""),
        ccInfo: TextFieldInfo = TextFieldInfo(text: ""),
        expiryInfo: TextFieldInfo = TextFieldInfo(text: ""),
        cvvInfo: TextFieldInfo = TextFieldInfo(text: "")
    ) {
        self.emailInfo = emailInfo
        self.ccInfo = ccInfo
        self.expiryInfo = expiryInfo
        self.cvvInfo = cvvInfo
    }


    public var creditCardImage: UIImage? {
        switch ccInfo.text.first {
        case "4":
            return AssetImage.ccVisa
        case "5":
            return AssetImage.ccMastercard
        case "6":
            return AssetImage.ccDiscover
        default:
            return AssetImage.ccBlank
        }
    }

    /**
     Formats a credit card number string by inserting a separator every four characters and truncating it if it exceeds the maximum length.

     - Parameters:
        - text: The credit card number string to be formatted.

     - Returns: A formatted credit card number string with a separator every four characters, truncated if it exceeds the maximum length.

     - Note: This function removes any non-digit characters from the input string before formatting.
     */
    public func formatCreditCardText(_ text: String?) -> String {
        guard let text = text else {
            return ""
        }
        var formattedText = text.filter { $0.isNumber }
        let maxLength = 16
        let chunkSize = 4
        let separator = "-"

        if formattedText.count > maxLength {
            let endIndex = formattedText.index(formattedText.startIndex, offsetBy: maxLength)
            formattedText = String(formattedText[..<endIndex])
        }

        let separatorIndices = stride(from: chunkSize, to: formattedText.count, by: chunkSize)
        for index in separatorIndices.reversed() {
            formattedText.insert(contentsOf: separator, at: formattedText.index(formattedText.startIndex, offsetBy: index))
        }

        return formattedText
    }

    /**
     Formats an expiry date string by inserting a separator between the first two characters.

     - Parameters:
        - text: The expiry date string to be formatted.

     - Returns: A formatted expiry date string with a separator between the first two characters.

     - Note: This function truncates the input string if it exceeds the maximum length of four characters.
     */
    public func formatExpiryDateText(_ text: String?) -> String {
        guard let text = text else {
            return ""
        }
        var formattedText = text.filter { $0.isNumber }
        let maxLength = 4
        let separator = "/"
        if formattedText.count > maxLength {
            let endIndex = formattedText.index(formattedText.startIndex, offsetBy: maxLength)
            formattedText = String(formattedText[..<endIndex])
        }
        if formattedText.count > 2 {
            let index = formattedText.index(formattedText.startIndex, offsetBy: 2)
            formattedText.insert(contentsOf: separator, at: index)
        }
        return formattedText
    }

    /**
     Limits the input string to a maximum of three characters.

     - Parameters:
        - text: The input string to be limited.

     - Returns: A string with a maximum of three characters.
     */
    public func formatCVVText(_ text: String?) -> String {
        guard let text = text else {
            return ""
        }
        let maxLength = 3
        if text.count > maxLength {
            let endIndex = text.index(text.startIndex, offsetBy: maxLength)
            return String(text[..<endIndex])
        }

        return text
    }

    /**
     Validates an email address string to check if it is valid.

     - Parameters:
        - email: The email address string to be validated.

     - Returns: A Boolean value indicating whether the email address is invalid.

     - Note: The function checks if the email address string is empty. If it is empty, it is considered valid and the function returns `false`. Otherwise, the function uses a regular expression pattern to validate the email address format. If the email address matches the expected format, the function sets the `isValid` property of the `emailInfo` instance in the view model to `false` and returns `false` indicating that the email address is valid. If the email address does not match the expected format, the function returns `true`, indicating that the email address is invalid.

     - Important: The function assumes that the `emailInfo` property in the view model is an instance of `TextFieldInfo` and it is used to track the validity of the email address field.
     */
    public func isInvalidEmail(_ email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if  emailPred.evaluate(with: email) {
            emailInfo.isValid = false
            return false
        } else {
            return true
        }
    }

    /**
     Validates an expiry date string to check if it is valid and not expired.

     - Parameters:
        - expiryDate: The expiry date string to be validated.

     - Returns: A Boolean value indicating whether the expiry date is invalid or expired.

     - Note: The function checks if the expiry date string is empty. If it is empty, it is considered valid and the function returns `false`. Otherwise, the function attempts to parse the expiry date using the format "MM/yy". If the parsing is successful and the expiry date is in the future, the function returns `false` indicating that the expiry date is invalid or expired. Additionally, if the parsing fails, the `expiryInfo.isValid` property in the view model is set to `false`.

     - Important: The function assumes that the `expiryInfo` property in the view model is an instance of `TextFieldInfo` and it is used to track the validity of the expiry date field.
     */
    public func isInvalidExpiryDate(_ expiryDate: String) -> Bool {
        guard !expiryDate.isEmpty else { return false }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let date = dateFormatter.date(from: expiryDate) {
            let currentDate = Date()
            return date < currentDate
        } else {
            expiryInfo.isValid = false
        }

        return true
    }

    private var validationPublisher: AnyPublisher<Bool, Never> {
           return Publishers.CombineLatest4(
               emailInfo.publisher,
               ccInfo.publisher,
               expiryInfo.publisher,
               cvvInfo.publisher
           )
           .map { email, cc, expiry, cvv in
               // Validate the individual fields and return the overall validation status
               let isEmailValid = !email.isEmpty && !self.isInvalidEmail(email)
               let isCCValid = !cc.isEmpty
               let isExpiryValid = !expiry.isEmpty && !self.isInvalidExpiryDate(expiry)
               let isCVVValid = !cvv.isEmpty

               return isEmailValid && isCCValid && isExpiryValid && isCVVValid
           }
           .eraseToAnyPublisher()
       }

    // Publisher to observe the overall validation status
    public var isValidPublisher: AnyPublisher<Bool, Never> {
            return validationPublisher
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
}
