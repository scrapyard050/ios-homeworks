//
//  TableViewCell.swift
//  Navigation
//
//  Created by Антон Соколов on 05.11.2021.
//

import UIKit

class LoginViewCell: UITableViewCell {

    private(set) lazy var loginTextFiled: UITextField = {
        let login = UITextField()
        login.placeholder = "Email of phone"
        login.textColor = UIColor.black
        login.translatesAutoresizingMaskIntoConstraints = false
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        return login
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.systemGray
        
        self.contentView.addSubview(loginTextFiled)
        loginTextFiled.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        loginTextFiled.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        loginTextFiled.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    
    }
    
    override func prepareForReuse() {
        self.accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use it")
    }
}
