//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Антон Соколов on 31.10.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let defaultWidth: CGFloat = {
       return 100
    }()
    
    private let defaultHeight: CGFloat = {
       return 100
    }()
    
    private weak var delegate: ProfileViewControllerDelegate?
    
    /// @brief  image view в рамках, которого размещается аватарка
    ///
    private(set)lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "cool_cat")
        avatarImageView.frame.size.height = defaultHeight
        avatarImageView.frame.size.width = defaultWidth
        avatarImageView.layer.masksToBounds = true
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.contentMode = UIView.ContentMode.scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    /// @brief Настраиваем констрейнты для отображения аватарки
    ///
    func setupAvatarLayout() {
        avatarImageView.widthAnchor.constraint(equalToConstant: defaultWidth).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: defaultHeight).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }
    
    /// @brief  Метка с описанием аватарки
    ///
    private(set)lazy var avatarLabel: UILabel = {
        let avatarLabel = UILabel()
        avatarLabel.font = UIFont.boldSystemFont(ofSize: 18)
        avatarLabel.textColor = UIColor.black
        avatarLabel.text = "Hipster Cat"
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        return avatarLabel
    }()
    
    /// @brief Настраиваем констрейнты для отображения метки с заголовком аватрки
    ///
    func setupAvatarLabelLayout() {
        avatarLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: self.frame.width/2).isActive = true
        avatarLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27).isActive = true
    }
    
    /// @brief  Метка с описанием ожидания получения статуса
    ///
    private(set)lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = UIFont.boldSystemFont(ofSize: 14)
        statusLabel.textColor = UIColor.gray
        statusLabel.text = "Waiting for something..."
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    /// @brief Настраиваем констрейнты для метки статуса
    ///
    func setupStatusLabelLayout() {
        statusLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: self.frame.width/2).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34).isActive = true
    }
    
    /// @brief Передадим обработку нажатия кнопки в контроллер 
    @objc func buttonPressed() {
        self.delegate?.tapButton()
    }
    
    /// @brief  Получение статуса
    ///
    private(set) lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Show status", for: .normal)
        statusButton.backgroundColor = UIColor.systemBlue
        statusButton.tintColor = UIColor.white
        statusButton.frame.size.height = 50
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowRadius = 4
        statusButton.layer.opacity = 0.7
        statusButton.layer.cornerRadius = 4
        statusButton.layer.masksToBounds = false
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return statusButton
    }()

    /// @brief Настраиваем констрейнты для кнопки получения статуса
    ///
    func setupStatusButtonLayout()
    {
        statusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        statusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        statusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16).isActive = true
    }
        
    /// @todo возможно имеет смысл перенести в конструктор, но могут полететь констрейнты
    /// 
    func addItems() {
        // добавляем аватарку и настраиваем констрейнты
        self.addSubview(avatarImageView)
        self.setupAvatarLayout()
        // добавляем метку с описанием аватарки и настраиваем констрейнты
        self.addSubview(avatarLabel)
        self.setupAvatarLabelLayout()
        // добавляем кнопку для получения статуса и настраиваем констрейнты
        self.addSubview(statusButton)
        self.setupStatusButtonLayout()
        // добавляем метку ожидания получения статуса
        self.addSubview(statusLabel)
        self.setupStatusLabelLayout()
        // обновляем макет
        self.layoutIfNeeded()
    }
    
    init(frame: CGRect, withDelegate: ProfileViewControllerDelegate) {
        super.init(frame: frame)
        self.delegate = withDelegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
