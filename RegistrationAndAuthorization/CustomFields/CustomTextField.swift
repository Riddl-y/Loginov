//
//  CustomTextField.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit


public final class CastomTextField: UIView {
    
    /// Название текстового поля
    private let myLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    /// Настраиваемое текстовое поле
    public lazy var myCastomTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.delegate = self
        return textField
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(views: [myLabel, myCastomTextField])
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Текс названия для настраиваемого текстового поля
    var labelText: String = "" {
        didSet {
            myLabel.text = labelText
        }
    }
    /// Текст заполнителя для настраиваемого текстового поля
    var placeholderText: String = "" {
        didSet {
            myCastomTextField.placeholder = placeholderText
        }
    }
    /// Тип отображаемой клавиатуры для настраиваемого текстового поля
    var keyboardTypeTextField: UIKeyboardType = .default {
        didSet {
            myCastomTextField.keyboardType = keyboardTypeTextField
        }
    }
    /// Текст введенный в текстовое поле
    var textFieldText: String {
        return myCastomTextField.text ?? ""
    }
    
    /// Установи ограничения
    private func configureConstraints() {
        
        myLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview()
        }
        
        myCastomTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(myLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
}


extension CastomTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myCastomTextField.resignFirstResponder()
    }
}
