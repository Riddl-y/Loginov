//
//  LoginViewController.swift
//  RegistrationAndAuthorization
//
//  Created by Александр Логинов on 23.11.2021.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    /// UILabel - loginLabel
    let loginLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        label.text = "Вход"
        label.textColor = .black
        label.layer.shadowOpacity = 0.4
        label.layer.shadowRadius = 4.0
        label.layer.shadowColor = UIColor.white.cgColor
        return label
    }()
    
    /// UITextField - emailTextField
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Eмейл", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.keyboardType = .emailAddress
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.contentMode = .scaleAspectFit
        return textField
    }()
    
    /// UITextField - passwordTextField
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.contentMode = .scaleAspectFit
        return textField
    }()
    
    /// Кнопка "Войти"
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    /// Кнопка "Регистрация"
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        return button
    }()
    
    /// UIAlertController - LoginViewController
    let myAlert: UIAlertController = {
        let alert = UIAlertController(title: "Не верные данные", message: "Введите Емайл и Пароль", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCostraints()
        setDelegates()
    }
    
    /// Установи делегатов
    func setDelegates(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    /// Установи ограничения
    func configureCostraints() {

        loginLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emailTextField.snp.centerX)
            make.centerY.equalToSuperview().offset(-100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(15)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.centerX).offset(-5)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.leading.equalTo(passwordTextField.snp.centerX).offset(5)
            
        }
    }
    
    /// Помести элементы на view
    func configureView(){
        view.backgroundColor = .white
        view.addSubviews(views: [loginLabel, emailTextField, passwordTextField, signUpButton, signInButton])
    }
    
    /// Action для кнопки Регистрация
    @objc func signUpButtonAction() {
        //let registrationViewCintroller = RegistrationViewController()
        let registrationViewCintroller2 = FirstRegistrationViewController()
        present(registrationViewCintroller2, animated: true)
    }
    
    /// Action для кнопки Войти
    @objc func signInButtonAction() {

        let user = UserDefault.shared
        
        // Если password и email есть в базе войди в систему
        if emailTextField.text == user.get(key: .email) && passwordTextField.text == user.get(key: .password){
            let registrationViewCintroller = FirstRegistrationViewController()
            present(registrationViewCintroller, animated: true)
        } else {
            // Покажи сообщение об ошибке
            present(myAlert, animated: true)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

