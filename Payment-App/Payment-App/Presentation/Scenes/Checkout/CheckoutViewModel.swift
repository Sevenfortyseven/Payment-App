//
//  PaymentViewModel.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import UIKit
import Combine

final class CheckoutViewModel {

    var emailText: String
    var ccInfo: String
    var expiryInfo: String
    var cvvInfo: String

    init(
        emailText: String = "",
        ccInfo: String = "",
        expiryInfo:  String = "",
        cvvInfo: String = ""
    ) {
        self.emailText = emailText
        self.ccInfo = ccInfo
        self.expiryInfo = expiryInfo
        self.cvvInfo = cvvInfo
    }


    public var creditCardImage: UIImage? {
        switch ccInfo.first {
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
    
}
