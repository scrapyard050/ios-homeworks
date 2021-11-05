//
//  PasswordViewCell.swift
//  Navigation
//
//  Created by Антон Соколов on 05.11.2021.
//

import UIKit

class PasswordViewCell: UITableViewCell {

    private(set) lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.textColor = UIColor.black
        password.translatesAutoresizingMaskIntoConstraints = false
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        return password
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.systemGray
        self.contentView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        self.accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use it")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


