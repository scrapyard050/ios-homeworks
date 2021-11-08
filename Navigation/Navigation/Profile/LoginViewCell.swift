//
//  TableViewCell.swift
//  Navigation
//
//  Created by Антон Соколов on 05.11.2021.
//

import UIKit

/// @brief ячейка для ввода логина
///
class LoginViewCell: UITableViewCell {

    @objc func activateKeyboard() {
        self.loginTextFiled.becomeFirstResponder()
    }
    
    /// @todo не задавал обработчики ввода данных в компонент, поскольку нет соответствующего условия в задаче
    private(set) lazy var loginTextFiled: UITextField = {
        let login = UITextField.init(frame: .zero)
        login.placeholder = "Email of phone"
        login.textColor = UIColor.black
        login.translatesAutoresizingMaskIntoConstraints = false
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        return login
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(loginTextFiled)
        self.loginTextFiled.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.loginTextFiled.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.loginTextFiled.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.activateKeyboard()
    }

    required init?(coder: NSCoder) {
        fatalError("Don't use it")
    }
}
