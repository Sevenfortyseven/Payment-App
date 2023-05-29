//
//  Entities.swift
//  Payment-App
//
//  Created by aleksandre on 29.05.23.
//

import Foundation
import Combine

public class TextFieldInfo: ObservableObject {
    @Published var text: String
    @Published var isValid: Bool

    public init(isValid: Bool = true, text: String) {
        self.isValid = isValid
        self.text = text
    }

    var publisher: AnyPublisher<String, Never> {
        $text
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
