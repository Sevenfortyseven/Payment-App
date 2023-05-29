//
//  Constants.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import UIKit

enum Constants {
    
    enum Spacing {
        static let large: CGFloat = 50.0
        static let medium: CGFloat = 20.0
        static let small: CGFloat = 5.0
    }

    enum Offset {
        static let leading: CGFloat = 30.0
        static let trailing: CGFloat = -30.0
        static let top: CGFloat = 30.0
        static let bot: CGFloat = -30.0
    }

    enum Height {
        static let divider: CGFloat = 0.3
        static let checkoutTextField: CGFloat = 50.0
        static let roundButton: CGFloat = 50.0
    }

    enum CharacterLength {
        static let creditCard: Int = 19
        static let expiryDate: Int = 5
        static let cvv = 3
    }
}
