//
//  LogInViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 05.11.2021.
//

import UIKit

/// @brief Аутентификация пользователя
///
class LogInViewController: UIViewController {
    

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
        logo.bottomAnchor.constraint(lessThanOrEqualTo: self.stackView.safeAreaLayoutGuide.topAnchor, constant: -120).isActive = true
    }
    
    
    /// @todo не задавал обработчики ввода данных в компонент, поскольку нет соответствующего условия в задаче
    private lazy var loginTextFiled: UITextField = {
        let login = UITextField.init(frame: .zero)
        login.placeholder = "Email of phone"
        login.textColor = UIColor.black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
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
        return password
    }()
    
    

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = UIColor.lightGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        // добавляем отступ для ввода данные
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    /// @brief  настройка констрейнтов таблицы
    ///
    func setupStackViewLayout() {
        self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.logButton.topAnchor, constant: -16).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    /// @brief обработчик нажатия кнопки логина
    ///
    @objc func tapLoginButton(sender: UIButton) {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    // кнопка логина
    private(set) lazy var logButton: UIButton = {
        let logButton = UIButton()
        logButton.setTitle("Log in", for: .normal)
        logButton.backgroundColor = self.colorFromRGB(rgbValue: 0x4885CC)
        logButton.tintColor = UIColor.white
        logButton.layer.cornerRadius = 10
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        return logButton
    }()
    
    /// @brief настройка констрейнтов кнопки логина
    ///
    func setupLogButtonLayout(keyboardHeight: CGFloat) {
        logButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        logButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16).isActive = true
        logButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: keyboardHeight).isActive = true
    }
    
    /// @brief Задание кастомного цвета
    ///
    func colorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @objc func handleKeyboardNotification(_ notification: Notification) {

        guard let info = notification.userInfo else {
            return
        }

        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyBoardHeightConstraint = notification.name == UIResponder.keyboardWillShowNotification ? -keyboardFrame!.height : 0
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.setupLogoLayout()
            self.setupStackViewLayout()
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
        
        self.stackView.addArrangedSubview(loginTextFiled)
        //self.stackView.addArrangedSubview(spacerView)
        self.stackView.addArrangedSubview(passwordTextField)
        
        self.view.addSubview(stackView)
        self.view.addSubview(logButton)
        self.view.backgroundColor = UIColor.white
        
        self.stackView.separator(color : .systemGray)
        
        // выполняем настройку autolayout
        self.setupLogoLayout()
        self.setupStackViewLayout()
        self.setupLogButtonLayout(keyboardHeight: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    }
    
}

 
/// @todo создаем разделить между поля ввода логина/пароля
extension UIStackView {
    func separator(color: UIColor) {
        let divider = UIView()
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = color
        // вставляем в позицию 1, то есть после поля для ввода логина, которое имеет индекс 0
        insertArrangedSubview(divider, at: 1)
        divider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    }
}
