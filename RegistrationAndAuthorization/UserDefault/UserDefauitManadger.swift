//
//  UserDefauitManadger.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation

/// Хранилище данных
class UserDefault {
    
    /// Ключи
    enum Key: String {
        case firstName
        case lastName
        case namberPhone
        case email
        case password
    }
    
    static let shared = UserDefault()
    
    let defaults = UserDefaults.standard
    
    /// Сохрани данные
    /// - Parameters:
    ///   - key: По ключу
    ///   - value: Данные которые необходимо сохранить 
    func set(key: Key, value: String) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    /// Покажи данные
    /// - Parameter key: По ключу
    /// - Returns: Сохраненные данные
    func get(key: Key) -> String {
        let value = defaults.object(forKey: key.rawValue)
        return value as! String
    }
}
