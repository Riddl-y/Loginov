//
//  ExtensionView.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(views: [UIView]) {
        for item in views {
            addSubview(item)
        }
    }
}
