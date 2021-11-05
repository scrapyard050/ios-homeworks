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
        table.layer.borderColor = UIColor.lightGray.cgColor
        table.layer.borderWidth = 5
        table.layer.cornerRadius = 10
        return table
    }()
    
    fileprivate lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private(set) lazy var logButton: UIButton = {
        let logButton = UIButton()
        logButton.setTitle("Log in", for: .normal)
        logButton.backgroundColor = UIColor.systemBlue
        logButton.tintColor = UIColor.white
        logButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        logButton.layer.shadowColor = UIColor.black.cgColor
        logButton.layer.shadowRadius = 4
        logButton.layer.opacity = 0.7
        logButton.layer.cornerRadius = 4
        logButton.layer.masksToBounds = false
        logButton.translatesAutoresizingMaskIntoConstraints = false
        return logButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(logo)
        self.view.addSubview(tableView)
        self.view.addSubview(logButton)
        self.view.backgroundColor = UIColor.white
        
        
        logo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logo.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: -120).isActive = true
        logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 120).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.logButton.topAnchor, constant: -16).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        logButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        logButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logButton.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 16).isActive = true
        logButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        logButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        tableView.register(LoginViewCell.self, forCellReuseIdentifier: "LoginViewCellReusable")
        tableView.register(PasswordViewCell.self, forCellReuseIdentifier: "PasswordViewCellReusable")
        tableView.isScrollEnabled = false
        tableView.tableFooterView?.isHidden = true
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
    

