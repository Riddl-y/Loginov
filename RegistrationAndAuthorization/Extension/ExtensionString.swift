//
//  ExtensionString.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit

extension String {
    
    /// Тип
    enum TextFieldType: String {
        case firstName
        case lastName
        case age
        case namberPhone
        case email
        case passwird
    }
    
    /// Регулярное вырожение
    enum Regex: String {
        /// Регулярное выражение для проверки вводимых данных в TextField
        case name = "[a-zA-Zа-яА-Я]{2,}"
        case email = "[a-zA-Z0-9._-]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        // В регулярном выражении указываем конструкци для обязательных символов (?=.*[]) в квадратные скобки указываем какие символы нужны для обязательного ввода
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
        case numberPhone = "[0-9]{11,}"
        case age = "^[0-3]?[0-9].[0-3]?[0-9].(?:[0-9]{2})?[0-9]{2}$"
    }
    
    /// Проверь введенные данные на регулярное выражение
    /// - Parameter isValidType: Тип проверяемого поля
    /// - Returns: Верни результат проверки true или false
    func isValidTextField(isValidType: TextFieldType) -> Bool {
        
        let format = "SELF MATCHES %@"
        
        var regex = ""
        
        switch isValidType {
        case .firstName:
            regex = Regex.name.rawValue
        case .lastName:
            regex = Regex.name.rawValue
        case .age:
            regex = Regex.age.rawValue
        case .namberPhone:
            regex = Regex.numberPhone.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .passwird:
            regex = Regex.password.rawValue

        }
        print("isValid \(NSPredicate(format: format, regex).evaluate(with: self))")
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}

