//
//  FirstRegistrationViewController .swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import Foundation
import UIKit

class FirstRegistrationViewController: UIViewController{
    
    /// UIScrollView
    let myScrolView: UIScrollView = {
        let scrolView = UIScrollView()
        return scrolView
    }()
    
    /// Хранилище данных пользователя
    let storage = UserDefault.shared
    
    /// Записывает текст полей для регистрации
    var sevText = SevValidText(firstNameText: "", lastNameText: "", ageText: "", namberPhoneText: "", emailText: "", passwordText: "")
    
    /// Модель
    let settingsArray: [FirstRegistrationViewModel] = [
        .init(placeholder: "Введите имя",
              nameTextField: "Имя",
              keyboardType: .default,
              typeTextField: .firstName),
        
            .init(placeholder: "Введите фамилию",
                  nameTextField: "Фамилия",
                  keyboardType: .default,
                  typeTextField: .lastName),
        
            .init(placeholder: "Выберите дату рождения",
                  nameTextField: "Дата рождения",
                  keyboardType: .numberPad,
                  typeTextField: .age),
        
            .init(placeholder: "Введите номер телефонаа",
                  nameTextField: "Номер телефона",
                  keyboardType: .phonePad,
                  typeTextField: .namberPhone),
        
            .init(placeholder: "Введите емейл",
                  nameTextField: "Емейл",
                  keyboardType: .emailAddress,
                  typeTextField: .email),
        
            .init(placeholder: "Введите пароль",
                  nameTextField: "Пароль",
                  keyboardType: .default,
                  typeTextField: .passwird)
    ]
    
    /// UIAlertController - FirstRegistrationViewController
    var myAlert: UIAlertController = {
        let alert = UIAlertController(title: "Ошибка", message: "Заполни все поля", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        return alert
    }()
    
    /// UILabel - registrationLabel
    let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = label.font.withSize(30)
        label.textColor = .black
        return label
    }()
    
    /// UIStackView - FirstRegistrationViewController
    let myStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    /// UIButton - signInButton
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signInButtonActionAlert), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        cofigureConstraints()
    }
    
    /// Настрой экран для отображения элементов
    func configureView() {
        view.backgroundColor = .white
        
        // Помести элементы на View
        view.addSubviews(views: [registrationLabel, myScrolView, signInButton])
        
        // Добавь UIStackView на ScrollView
        myScrolView.addSubview(myStackView)
        
        // Пройди по массиву элементов
        for seting in settingsArray {
            let registrationView = RegistrationView()
            // Примени настройки к каждому элементу массива
            registrationView.configureContent(textFielPlaceholder: seting.placeholder,
                                              nameTextFieldText: seting.nameTextField,
                                              keyboardType: seting.keyboardType,
                                              typeTextField: seting.typeTextField,
                                              firstRegistrationDelegate: self)
            
            // Помести полученные элементы на stackView
            myStackView.addArrangedSubview(registrationView)
        }
    }
    
    /// Установи ограничения
    func cofigureConstraints() {
        
        let cgButton: CGSize = CGSize(width: 190, height: 40)
        
        myScrolView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(registrationLabel.snp.bottom).offset(20)
            make.bottom.equalTo(signInButton.snp.top).offset(-20)
        }
        
        myStackView.snp.makeConstraints { make in
            make.height.equalTo(450)
            make.top.equalTo(myScrolView.snp.top)
            make.bottom.equalTo(myScrolView.snp.bottom).inset(10)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        signInButton.snp.makeConstraints { make in
            make.size.equalTo(cgButton)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
    /// Action для кнопки Registration
    @objc func signInButtonActionAlert() {
        
        // Если в поле нет символов
        if sevText.firstNameText.isEmpty
            && sevText.lastNameText.isEmpty
            && sevText.namberPhoneText.isEmpty
            && sevText.emailText.isEmpty
            && sevText.passwordText.isEmpty
        {
            // Покажи ошибку
            present(myAlert, animated: true)
        } else {
            // Если в поле есть символы, проверь их на валидность
            chekAllFilds()
        }
    }
    
    /// Проверь все ли поля валидны
    func chekAllFilds() {
        let loginViewController = UINavigationController(rootViewController: LoginViewController())
        
        // Если какое-то из полей не валидно
        if !sevText.firstNameText.isValidTextField(isValidType: .firstName) {
            // Покажи ошибку
            myAlert.message = "Поле 'Имя' не верно! \n Минимум 2 символа, только буквы"
            present(myAlert, animated: true)
        } else if !sevText.lastNameText.isValidTextField(isValidType: .lastName){
            myAlert.message = "Поле 'Фамилия' не верно! \n Минимум 2 символа, только буквы"
            present(myAlert, animated: true)
        } else if !sevText.namberPhoneText.isValidTextField(isValidType: .namberPhone) {
            myAlert.message = "Поле 'Номер телефона' не верно! \n Минимум 11 символа, x-xxx-xxx-xx-xx"
            present(myAlert, animated: true)
        } else if !sevText.emailText.isValidTextField(isValidType: .email){
            myAlert.message = "Поле 'Email' не верно! \n x@x.xx"
            present(myAlert, animated: true)
        } else if !sevText.passwordText.isValidTextField(isValidType: .passwird){
            myAlert.message = "Поле 'Пароль' не верно! \n Должен состоять и букв верхнего и нижнего регистра, минимум 1 цифры и минимум из 6 символов"
            present(myAlert, animated: true)
        } else {
            // Если все поля валидны, сохрани данные email и password
            storage.set(key: .email, value: sevText.emailText)
            storage.set(key: .password, value: sevText.passwordText)
            // Перейди на экран LoginViewController
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true)
        }
    }
}

extension FirstRegistrationViewController: FirstRegistrationViewProtocol {
    
    /// Сохраняет введенный текст
    /// - Parameters:
    ///   - validType: Тип поля
    ///   - string: Введенный в поле текст
    func saveTextFieldsText(fieldType: String.TextFieldType, string: String) {
        
        switch fieldType {
        case .firstName:
            sevText.firstNameText = string
        case .lastName:
            sevText.lastNameText = string
        case .age:
            sevText.ageText = string
        case .namberPhone:
            sevText.namberPhoneText = string
        case .email:
            sevText.emailText = string
        case .passwird:
            sevText.passwordText = string
        }
    }
}
