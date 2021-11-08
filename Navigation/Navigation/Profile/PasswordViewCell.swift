//
//  PasswordViewCell.swift
//  Navigation
//
//  Created by Антон Соколов on 05.11.2021.
//

import UIKit

/// @brief ячейка для ввода пароя
///
class PasswordViewCell: UITableViewCell {

    /// @todo не задавал обработчики ввода данных в компонент, поскольку нет соответствующего условия в задаче
    private(set) lazy var passwordTextField: UITextField = {
        let password = UITextField.init(frame: .zero)
        password.placeholder = "Password"
        password.textColor = UIColor.black
        password.translatesAutoresizingMaskIntoConstraints = false
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        return password
    }()
    
    /// @brief В конструкторе задачем textfiled в ячейку и добавляем констрейнты
    ///
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Don't use it")
    }
    
}


