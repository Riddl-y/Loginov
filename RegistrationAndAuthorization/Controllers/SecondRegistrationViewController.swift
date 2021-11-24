//
//  SecondRegistrationViewController.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit

class SecondRegistrationViewController: UIViewController {
    
    // Хранилище
    let storage = UserDefault.shared
    
    /// UIScrollView
    let myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    /// UILabel
    let registrationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Регистрация"
        label.font = label.font.withSize(30)
        return label
    }()
    
    /// CastomTextField - Имя
    lazy var firstNameTextField: CastomTextField = {
        let textField = CastomTextField()
        textField.labelText = "Имя"
        textField.placeholderText = "Введи Имя"
        return textField
    }()
    
    /// CastomTextField - Фамилия
    let lastNameTextField: CastomTextField = {
        let textField = CastomTextField()
        textField.labelText = "Фамилия"
        textField.placeholderText = "Введи Фамилию"
        return textField
    }()
    
    /// CastomTextField - Дата рождения
    let ageTextField: CastomTextField = {
        let textField = CastomTextField()
        textField.labelText = "Дата рождения"
        textField.placeholderText = "Выбери дату рождения"
        
        // UIDatePicker Для выбора даты рождения
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = .init(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .wheels
        
        // Покажи UIDatePicker при выборе поля "Дата рождения"
        textField.myCastomTextField.inputView = datePicker
        
        // Установи размер панели для кнопок "Отмена" и "Выбрать"
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        
        // Кнопка "Отмена"
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelBtnClick))
        
        // Кнопка "Выбрать"
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(doneBtnClick))
        
        // Помести кнопки на панель
        toolbar.setItems([cancelButton, doneButton], animated: true)
        
        textField.myCastomTextField.inputAccessoryView = toolbar
        
        return textField
    }()
    
    /// CastomTextField - Номер телфона
    let numberPhoneTextField: CastomTextField = {
        let textField = CastomTextField()
        textField.labelText = "Номер телефона"
        textField.placeholderText = "Введи номер телефона"
        return textField
    }()
    
    /// CastomTextField - Емейл
    let emailTextField: CastomTextField = {
        let textField = CastomTextField()
        textField.labelText = "Емейл"
        textField.placeholderText = "Введи емейл"
        return textField
    }()
    
    /// CastomTextField - Пароль
    let passwordTextField: CastomTextField = {
        let textField = CastomTextField()
        textField.labelText = "Пароль"
        textField.placeholderText = "Введи пароль"
        return textField
    }()
    
    /// UIButton - registrationButton
    let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        return button
    }()
    
    /// UIAlertController
    var myAlert: UIAlertController = {
        let alert = UIAlertController(title: "Ошибка", message: "Заполни все поля", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        return alert
    }()
    
    /// UIStackView
    var myStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureView()
        cofigureConstraints()
        
    }
    
    /// Настрой экран для отображения элементов
    func configureView() {
        
        // Помести элементы на View
        view.addSubviews(views: [registrationLabel, myScrollView, registrationButton])
        
        // Настройка и заполнение UIStackView
        myStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                     lastNameTextField,
                                                     ageTextField,
                                                     numberPhoneTextField,
                                                     emailTextField,
                                                     passwordTextField],
                                  axis: .vertical,
                                  spacing: 10,
                                  distribution: .fillEqually,
                                  aligment: .fill)
        
        // Добавь UIStackView на ScrollView
        myScrollView.addSubview(myStackView)
    }
    
    /// Экшен для кнопки "Регистрация"
    @objc func registrationButtonAction() {
        
        // Если в полях отсутствует текст
        if firstNameTextField.textFieldText.isEmpty
            && lastNameTextField.textFieldText.isEmpty
            && numberPhoneTextField.textFieldText.isEmpty
            && emailTextField.textFieldText.isEmpty
            && passwordTextField.textFieldText.isEmpty
        {
            // Покажи ошибку
            present(myAlert, animated: true)
        } else {
            // Если текст присутствует проверить его на валидность
            checkValidText()
        }
    }
    
    /// Экшен для кнопки "Отмена" в UIDatePicker
    @objc func cancelBtnClick() {
        ageTextField.myCastomTextField.resignFirstResponder()
    }
    // Экшен для кнопки "Выбрать" в UIDatePicker
    @objc func doneBtnClick() {
        // Если выбрано поле ввода даты рождения покажи UIDatePicker
        if let datePicker = ageTextField.myCastomTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "ru-RU")
            dateFormatter.dateStyle = .short
            // Запиши выбранную дату в поле ageTextField
            ageTextField.myCastomTextField.text = dateFormatter.string(from: datePicker.date)
        }
        // Убери с экрана UIDatePicker
        ageTextField.myCastomTextField.resignFirstResponder()
    }
}

extension SecondRegistrationViewController {
    
    /// Установи ограничения
    func cofigureConstraints() {
        
        let cgButton: CGSize = CGSize(width: 190, height: 40)
        
        registrationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        myScrollView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(registrationLabel.snp.bottom).offset(20)
            make.bottom.equalTo(registrationButton.snp.top).offset(-20)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.size.equalTo(cgButton)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        myStackView.snp.makeConstraints { make in
            make.height.equalTo(500)
            make.leading.trailing.equalTo(view).inset(30)
            make.top.equalTo(myScrollView.snp.top)
            make.bottom.equalTo(myScrollView.snp.bottom)
        }
    }
    
    /// Метод для проверки валидности текста
    private func checkValidText() {
        let vcLogin = LoginViewController()
        
        let firstNameText = firstNameTextField.textFieldText
        let lastNameText = lastNameTextField.textFieldText
        let numberPhoneText = numberPhoneTextField.textFieldText
        let emailText = emailTextField.textFieldText
        let passwordText = passwordTextField.textFieldText
        
        // Если текст не валидный
        if !firstNameText.isValidTextField(isValidType: .firstName) {
            // Покажи ошибку
            myAlert.message = "Поле 'Имя' не верно! \n Минимум 2 символа, только буквы"
        } else if  !lastNameText.isValidTextField(isValidType: .lastName) {
            myAlert.message = "Поле 'Фамилия' не верно! \n Минимум 2 символа, только буквы"
        } else if  !numberPhoneText.isValidTextField(isValidType: .namberPhone) {
            myAlert.message = "Поле 'Номер телефона' не верно! \n Минимум 11 символа, x-xxx-xxx-xx-xx"
        } else if  !emailText.isValidTextField(isValidType: .email) {
            myAlert.message = "Поле 'Email' не верно! \n x@x.xx"
        } else if  !passwordText.isValidTextField(isValidType: .passwird) {
            myAlert.message = "Поле 'Пароль' не верно! \n Должен состоять и букв верхнего и нижнего регистра, минимум 1 цифры и минимум из 6 символов"
        } else {
            // Если текст валидный сохрани "email" и "password" для входа в систему
            storage.set(key: .email, value: emailText)
            storage.set(key: .password, value: passwordText)
            // Перейди на экран авторизации LoginViewController
            vcLogin.modalPresentationStyle = .fullScreen
            present(vcLogin, animated: true)
        }
        present(myAlert, animated: true)
    }
}

