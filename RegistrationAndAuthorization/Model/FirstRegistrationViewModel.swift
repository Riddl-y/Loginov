//
//  FirstRegistrationViewModel.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit

/// Модель для FirstRegistrationViewController что бы настроить контент
struct FirstRegistrationViewModel {
    let placeholder: String
    let nameTextField: String
    let keyboardType: UIKeyboardType
    let typeTextField: String.TextFieldType
}

/// Для хранения введенного текста
struct SevValidText {
    var firstNameText: String
    var lastNameText: String
    var ageText: String
    var namberPhoneText: String
    var emailText: String
    var passwordText: String
}
