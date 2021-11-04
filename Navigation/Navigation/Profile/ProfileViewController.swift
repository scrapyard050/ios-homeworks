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

class ProfileViewController: UIViewController, UINavigationBarDelegate {
   
    private var profile: ProfileHeaderView?
    
    // для простоты сделаем пустую переменную
    private lazy var statusText: String = {
        return ""
    }()
    
    /// @todo макетов нет поэтому создаем свою кнопку
    ///
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("TEST", for: .normal)
        button.backgroundColor = UIColor.systemYellow
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 4
        button.layer.opacity = 0.8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapTestButton), for: .touchUpInside)
        return button
    }()
    
    /// @brief Обработчик нажатия кнопки
    /// Выодим лог в консоль
    ///
    @objc func tapTestButton() {
        NSLog("Test button is tapped")
    }
    
    /// @Настройка констрейнтов для отображения кнопки
    ///
    func setupTestButtonLayout() {
        self.testButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.testButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.testButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /// @brief Создаем стандарный навигейшен бар с заголовком
    func createNavigationBar() {
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50));
        let barItem = UINavigationItem(title: "Profile")
        bar.setItems([barItem], animated: false)
        self.view.addSubview(bar)
    }
    
  
    func setupProfileViewLayout() {
        guard let profile = self.profile else { return }
        // относительно заданного фрэйма будут выстраиваться компоненты заданные на profileView
        profile.frame = self.view.frame
        profile.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        profile.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        let constraint = profile.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
        profile.frame.size.height = 220
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar()
        self.view.backgroundColor = .lightGray
        self.profile = ProfileHeaderView(frame: .zero, withDelegate: self)
        guard let profile = self.profile else { return }
        self.view.addSubview(profile)
        setupProfileViewLayout()
        profile.addItems()
        // @todo по поводу пунктра 3 непонятно где создавать новую кнопку
        // поэтому сделал ее в котроллере
        self.view.addSubview(testButton)
        self.setupTestButtonLayout()
    }

}

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
