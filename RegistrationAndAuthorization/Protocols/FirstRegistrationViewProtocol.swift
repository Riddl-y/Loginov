//
//  FirstRegistrationViewProtocol.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit

/// Протокол для связи Controller и View
protocol FirstRegistrationViewProtocol: AnyObject {
    /// Возми данные и сохрани
    func saveTextFieldsText(fieldType: String.TextFieldType, string: String)
}
