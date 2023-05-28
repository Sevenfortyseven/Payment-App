//
//  PaymentViewModel.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import Foundation
import Combine

final class CheckoutViewModel {

    var emailText: String
    var ccInfo: String
    var expiryInfo: String
    var cvvInfo: String

    init(
        emailText: String = "",
        ccInfo: String = "",
        expiryInfo: String = "",
        cvvInfo: String = ""
    ) {
        self.emailText = emailText
        self.ccInfo = ccInfo
        self.expiryInfo = expiryInfo
        self.cvvInfo = cvvInfo
    }
}
