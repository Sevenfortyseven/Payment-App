//
//  UITextField+TextPublisher.swift
//  Payment-App
//
//  Created by aleksandre on 28.05.23.
//

import Combine
import UIKit

extension UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
}
