//
//  LogInViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 05.11.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.frame.size.height = 100
        table.layer.borderColor = UIColor.lightGray.cgColor
        table.layer.borderWidth = 5
        table.layer.cornerRadius = 10
        return table
    }()
    
    
    fileprivate let data = ["Login", "Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.white
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -340).isActive = true
        tableView.register(LoginViewCell.self, forCellReuseIdentifier: "LoginViewCellReusable")
        tableView.register(PasswordViewCell.self, forCellReuseIdentifier: "PasswordViewCellReusable")
        self.tableView.dataSource = self
    }
}

extension LogInViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            guard let login = tableView.dequeueReusableCell(withIdentifier: "LoginViewCellReusable", for: indexPath) as? LoginViewCell else {
                fatalError()
            }
            return login
        }
        guard let password = tableView.dequeueReusableCell(withIdentifier: "PasswordViewCellReusable", for: indexPath) as? PasswordViewCell else {
            fatalError()
        }
        return password
        
    }
}
    

