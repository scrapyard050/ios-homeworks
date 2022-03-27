//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 19.10.2021.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    // обработка события нажатия кнопки и выставление статуса
    func tapButton(handler:(_ status: String) ->Void)
    // обработка события ввода текста в компонент textField
    func editingText(text: Character )
}

class ProfileViewController: UIViewController {
    // MARK: Public properties
    var userService: UserService
    var userName: String
    
    // MARK: Private properties
    private let profile = ProfileHeaderView()
 
    // для простоты сделаем пустую переменную
    private lazy var statusText: String = {
        return ""
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        // регистрируем ячейку и выставляем себя на получение событий от tableView
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.tableViewCellId)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: Constructors
    init(userService: UserService, userName: String) {
#if DEBUG
        self.userService = TestUserService()
#else
        self.userService = userService
#endif
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.userInfo()
        self.profile.delegate = self
    }
    
    // MARK: Public methods
    
    func prepareUI() {
        self.view.addSubviews(self.tableView)
        let constraints =
        [
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func userInfo() {
        guard let user =  self.userService.user(name: self.userName) else {
            return
        }
        
        print("User name: \(user.name)")
        print("User avatar: \(user.avatar)")
        print("User status: \(user.status)")
    }
}

// MARK: Extensions
extension ProfileViewController: ProfileViewControllerDelegate {
    func tapButton(handler:(_ status: String) ->Void) {
        NSLog("Button is tapped")
        handler(self.statusText)
        self.statusText = ""
    }
    
    func editingText(text: Character ){
        self.statusText += String(text)
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    // возвращаем количество столбцов для секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // возвращаем посты только для нулевой секции (если я правильно понял условия задачи)
        guard section == 0 else { return .zero }
        return ExtendedPost.posts.count
    }
    
    // Получаем ячейку по идентификатору и выполняем ее настройку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.tableViewCellId, for: indexPath ) as? PostTableViewCell else { return UITableViewCell()}
        
        cell.setupCell(extendedPost: ExtendedPost.posts[indexPath.row])
        return cell
    }
}

// для нулевой секции задаем профайл в качестве хедара и выставляем расчет высоты на основе содержимого
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section == 0 else { return .zero }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil}
        return profile
    }
    
}



