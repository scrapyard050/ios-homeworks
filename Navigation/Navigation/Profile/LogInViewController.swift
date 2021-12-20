//
//  LogInViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 05.11.2021.
//

import UIKit

/// @brief Аутентификация пользователя
///
class LogInViewController: UIViewController  {
    

    //  логотип сервиса куда выполняется подключение
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    /// @brief настройка констрейнтов логотипа
    ///
    func setupLogoLayout() {
        logo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logo.topAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        logo.bottomAnchor.constraint(lessThanOrEqualTo: self.containerView.safeAreaLayoutGuide.topAnchor, constant: -120).isActive = true
    }
    
    
    /// @todo не задавал обработчики ввода данных в компонент, поскольку нет соответствующего условия в задаче
    private lazy var loginTextFiled: UITextField = {
        let login = UITextField.init(frame: .zero)
        login.placeholder = "Email of phone"
        login.textColor = UIColor.black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.backgroundColor = .clear
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    /// @todo не задавал обработчики ввода данных в компонент, поскольку нет соответствующего условия в задаче
    private lazy var passwordTextField: UITextField = {
        let password = UITextField.init(frame: .zero)
        password.placeholder = "Password"
        password.textColor = UIColor.black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.backgroundColor = .clear
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor.systemGray6
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    
    /// @brief  настройка констрейнтов таблицы
    ///
    func setupContainerViewLayout() {
        self.containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.logButton.topAnchor, constant: -16).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    /// @brief обработчик нажатия кнопки логина
    ///
    @objc func tapLoginButton(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    // кнопка логина
    private(set) lazy var logButton: UIButton = {
        let logButton = UIButton()
        logButton.setTitle("Log in", for: .normal)
        logButton.tintColor = UIColor.white
        logButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logButton.layer.cornerRadius = 10
        logButton.clipsToBounds = true
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        return logButton
    }()
    
    /// @brief настройка констрейнтов кнопки логина
    ///
    func setupLogButtonLayout(keyboardHeight: CGFloat) {
        logButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        logButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logButton.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 16).isActive = true
        logButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if( 0 != keyboardHeight) {
            logButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: keyboardHeight).isActive = true
        }
    }
    
    
    @objc func handleKeyboardNotification(_ notification: Notification) {

        guard let info = notification.userInfo else {
            return
        }

        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyBoardHeightConstraint = notification.name == UIResponder.keyboardWillShowNotification ? -keyboardFrame!.height : 0
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.setupLogoLayout()
            self.setupContainerViewLayout()
            self.setupLogButtonLayout(keyboardHeight: keyBoardHeightConstraint)
            self.view.layoutIfNeeded()
        })
   }
    
    /// @todo в соответствии с условием задачи код по работе с компонентами не выносил в отдельные классы
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // выстраиваем иерархию компонентов
        self.view.addSubview(logo)
        
        self.view.addSubview(containerView)
        self.view.addSubview(logButton)
        self.view.backgroundColor = UIColor.white
        
        
        // выполняем настройку autolayout
        self.setupLogoLayout()
        self.setupContainerViewLayout()
        
        
        self.containerView.addSubview(loginTextFiled)
        self.loginTextFiled.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        self.loginTextFiled.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        self.loginTextFiled.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.loginTextFiled.heightAnchor.constraint(equalToConstant: 49.25).isActive = true
        
        
        let divider = UIView()
        containerView.addSubview(divider)
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        divider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        divider.topAnchor.constraint(equalTo: loginTextFiled.bottomAnchor).isActive = true
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .systemGray
    
        
        self.containerView.addSubview(passwordTextField)
        self.passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        self.passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        self.passwordTextField.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 1).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 49.25).isActive = true
        
        
        self.setupLogButtonLayout(keyboardHeight: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    }
}


