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
        logo.toAutoLayout()
        return logo
    }()
    
    /// @todo не задавал обработчики ввода данных в компонент, поскольку нет соответствующего условия в задаче
    private lazy var loginTextFiled: UITextField = {
        let login = UITextField.init(frame: .zero)
        login.placeholder = "Email of phone"
        login.textColor = UIColor.black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.backgroundColor = .clear
        login.toAutoLayout()
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
        password.toAutoLayout()
        return password
    }()
    

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor.systemGray6
        containerView.toAutoLayout()
        return containerView
    }()
    
    // кнопка логина
    private(set) lazy var logButton: UIButton = {
        let logButton = UIButton()
        logButton.setTitle("Log in", for: .normal)
        logButton.tintColor = UIColor.white
        logButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logButton.layer.cornerRadius = 10
        logButton.clipsToBounds = true
        logButton.toAutoLayout()
        logButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        return logButton
    }()
    
    private(set) lazy var divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .systemGray
        divider.toAutoLayout()
        return divider
    }()
    
    /// @brief обработчик нажатия кнопки логина
    ///
    @objc func tapLoginButton(sender: UIButton) {
        self.view.endEditing(true)
        /// @todo по требованиям задачи нет описания для полей аватар и статус,
        ///  То есть ннепонятно как они должны передаваться, как доджен создаваться обьект пользователя,  пока что передаем дефайны
        ///  В условиях задачи ничего не сказано про верификацию имени пользователя
        ///  Считаем что если хоть какие-то данные введены то используем для создания пользователя
        guard let userName = loginTextFiled.text else {
            return
        }
        
        let currentUserService = CurrentUserService(user: User(name: userName,
                                                               avatar: Constants.infoNotDefined,
                                                               status: Constants.infoNotDefined ))
        
        self.navigationController?.pushViewController(ProfileViewController(userService: currentUserService, userName: userName), animated: true)
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
    
    /// @brief настройка констрейнтов логотипа
    ///
    func setupLogoLayout() {
        let constraints = [
            self.logo.widthAnchor.constraint(equalToConstant: Constants.logoSize),
            self.logo.heightAnchor.constraint(equalToConstant: Constants.logoSize),
            self.logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logo.topAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.logoTopMargin),
            self.logo.bottomAnchor.constraint(lessThanOrEqualTo: self.containerView.safeAreaLayoutGuide.topAnchor, constant: -Constants.logoBottomMargin),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    /// @brief  настройка констрейнтов таблицы
    ///
    func setupContainerViewLayout() {
        let constraints = [
            self.containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.defaultMargin),
            self.containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.defaultMargin),
            self.containerView.bottomAnchor.constraint(equalTo: self.logButton.topAnchor, constant: -Constants.defaultMargin),
            self.containerView.heightAnchor.constraint(equalToConstant: Constants.containerViewHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    /// @brief настройка констрейнтов кнопки логина
    ///
    func setupLogButtonLayout(keyboardHeight: CGFloat) {
        let constraints = [
            self.logButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.defaultMargin),
            self.logButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.defaultMargin),
            self.logButton.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: Constants.defaultMargin),
            self.logButton.heightAnchor.constraint(equalToConstant: Constants.logButtonHeight)
        ]
        NSLayoutConstraint.activate(constraints)
       
        if( 0 != keyboardHeight) {
            self.logButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: keyboardHeight).isActive = true
        }
    }
    
    func prepareUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubviews(self.logo,
                              self.containerView,
                              self.logButton)
        
        self.containerView.addSubviews(self.loginTextFiled,
                                       self.divider,
                                       self.passwordTextField)
        let constraints = [
            self.loginTextFiled.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Constants.loginTextFiledLeftMargin),
            self.loginTextFiled.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.loginTextFiled.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.loginTextFiled.heightAnchor.constraint(equalToConstant: Constants.inputAuthDataTextFiledHeight),
            self.divider.heightAnchor.constraint(equalToConstant: Constants.dividerHeight),
            self.divider.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Constants.dividerLeftMargin),
            self.divider.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.divider.topAnchor.constraint(equalTo: self.loginTextFiled.bottomAnchor),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.passwordTextField.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: Constants.passwordTextFieldTopMargin),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: Constants.inputAuthDataTextFiledHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        self.setupLogoLayout()
        self.setupContainerViewLayout()
        self.setupLogButtonLayout(keyboardHeight: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}


