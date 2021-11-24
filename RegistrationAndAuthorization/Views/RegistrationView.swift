//
//  RegistrationView.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit

class RegistrationView: UIView {
    
    /// Связь между FirstRegistrationViewController и RegistrationView
    weak var delegate: FirstRegistrationViewProtocol?
    
    /// textFieldType
    var textFieldType: String.TextFieldType = .lastName
    
    /// UILabel
    let nameTextField: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    /// UITextField
    lazy var myTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = ""
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.delegate = self
        return textField
    }()
    
    /// UIDatePicker
    let myDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.datePickerMode = .date
        datePicker.locale = .init(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Установи ограничения
    func configureConstraints() {
        nameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
        }
        
        myTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(nameTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    /// Настрой экран для отображения элементов
    func configureView() {
        // Добавь элементы
        addSubviews(views: [myTextField, nameTextField])
    }
    
    /// Настрой контент
    /// - Parameters:
    ///   - textFielPlaceholder: Плейсхолдер для textField
    ///   - keyboardType: Тип клавиатуры
    ///   - typeTextField: Тип для доступа к textField
    ///   - registrationDelegate: Делегат для связи контроллера и view
    public func configureContent(textFielPlaceholder: String,
                                 nameTextFieldText: String,
                                 keyboardType: UIKeyboardType,
                                 typeTextField: String.TextFieldType,
                                 firstRegistrationDelegate: FirstRegistrationViewProtocol) {
        myTextField.placeholder = textFielPlaceholder
        nameTextField.text = nameTextFieldText
        myTextField.keyboardType = keyboardType
        textFieldType = typeTextField
        delegate = firstRegistrationDelegate
    }
    
}

extension RegistrationView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Запиши приходящий текст из textField в переменную text, если нет текста в textField возми текст со string
        let text = (textField.text ?? "") + string
        
        var result: String
        // Подсчет символов в поле ввода
        if range.length == 0 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
            
        }
        
        textField.text = result
        
        self.delegate?.saveTextFieldsText(fieldType: textFieldType, string: text)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        // Если выбранное поле ввода age покажи datePicker для выбора даты
        if textFieldType == .age {
            setDatePicker(textField: textField)
        }
    }
}

extension RegistrationView {
    
    /// Покажи datePicker
    /// - Parameter textField: Поле в котором активируется datePicker
    func setDatePicker(textField: UITextField) {
        
        textField.inputView = myDatePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelBtnClick))
        
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneBtnClick))

        toolbar.setItems([cancelButton, doneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
    }
    
    @objc func cancelBtnClick() {
        myTextField.resignFirstResponder()
    }
    
    @objc func doneBtnClick() {
        if let datePicker = myTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "ru-RU")
            dateFormatter.dateStyle = .short
            myTextField.text = dateFormatter.string(from: datePicker.date)
        }
        myTextField.resignFirstResponder()
    }
}


