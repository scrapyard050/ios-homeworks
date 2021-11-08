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
    
    fileprivate let countRow  = 2
    fileprivate let loginCellId = "LoginViewCellReusable"
    fileprivate let passwdCellId = "PasswordViewCellReusable"
    
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
    }
    
    
    // таблица для ввода реквизитов доступа
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.borderColor = UIColor.lightGray.cgColor
        table.layer.borderWidth = 5
        table.layer.cornerRadius = 10
        return table
    }()
    
    /// @brief  настройка констрейнтов таблицы
    ///
    func setupTableViewLayout() {
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.logButton.topAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(lessThanOrEqualTo: self.logo.bottomAnchor, constant: 120).isActive = true
        /// @todo поскольку стандартная  высота ячейки равна 44 и таблица состоит из двух полей то поставил значение 88
        tableView.heightAnchor.constraint(equalToConstant: 88).isActive = true
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
        logButton.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 16).isActive = true
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
            self.setupTableViewLayout()
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
        self.view.addSubview(tableView)
        self.view.addSubview(logButton)
        self.view.backgroundColor = UIColor.white
        
        
        // выполняем настройку autolayout
        self.setupLogoLayout()
        self.setupTableViewLayout()
        self.setupLogButtonLayout(keyboardHeight: 0)
        
        // регистрируем ячейки с которыми будет работать с таблица
        self.tableView.register(LoginViewCell.self, forCellReuseIdentifier: loginCellId)
        self.tableView.register(PasswordViewCell.self, forCellReuseIdentifier: passwdCellId)
        self.tableView.isScrollEnabled = false
        
        // пока что выставляем стандартную высоту ячейки
        // при использовании uitableviewautomaticdimension выводятся ворнинги
        // возможно нужно вернуть значение uitableviewautomaticdimension через метод делегата
        self.tableView.rowHeight = 44
        // связываем таблицу с методами протокола UITableViewDataSource
        self.tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    
    }

    
    
}

/// @brief работа с методами протокола UITableViewDataSource
extension LogInViewController: UITableViewDataSource {
    
    /// @brief возвращает количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countRow
    }
    
    /// @brief возвращает ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            guard let login = tableView.dequeueReusableCell(withIdentifier: loginCellId, for: indexPath) as? LoginViewCell else {
                fatalError("Login cell not found")
            }
            return login
        }
        guard let password = tableView.dequeueReusableCell(withIdentifier: passwdCellId, for: indexPath) as? PasswordViewCell else {
            fatalError("Password cell not found")
        }
        return password
        
    }
}
    

