//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Антон Соколов on 31.10.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    // стандартный отступ используемый в проекта, возможно стоит вынести в глобальную переменную
    // поскольку используется в различных экранах
    private let defaultMargin: CGFloat = {
       return 16
    }()
    
    // делегат для возвращашения введенных данных в контроллер
    public weak var delegate: ProfileViewControllerDelegate?
    
    /// @brief  image view в рамках, которого размещается аватарка
    ///
    private(set)lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "cool_cat")
        avatarImageView.layer.masksToBounds = true
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.contentMode = UIView.ContentMode.scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
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
    
    /// @brief  Получение статуса
    ///
    private(set) lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Show status", for: .normal)
        statusButton.backgroundColor = UIColor.systemBlue
        statusButton.tintColor = UIColor.white
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
    
    /// @brief  Задание статуса
    private(set) lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.backgroundColor = UIColor.white
        statusTextField.placeholder = "Input status"
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.borderWidth = 1
        statusTextField.textColor = UIColor.black
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return statusTextField
    }()
    
    /// @brief Передадим обработку нажатия кнопки в контроллер 
    @objc private func buttonPressed() {
        guard let text = self.statusTextField.text else {
            return
        }
        
        if text.isEmpty {
            return
        }
        
        self.delegate?.tapButton{
            self.statusLabel.text = $0
            self.statusTextField.text = ""
        }
    }
    

    /// @brief Обработчик ввода текста в компонент uitextfield
    /// Обработку текста передаем в контроллер через делегат
    ///
    @objc private func statusTextChanged(_ textField: UITextField) {
        // поскольку пользователь начал вводить текст, считаем что данные уже есть
        // поэтому делаем небезопасное извлечение данных
        self.delegate?.editingText(text: (textField.text?.last!)!)
    }
    
   
    // настройка отображения компонентов на экране
    private func setupComponents() {
        self.backgroundColor = .white
        self.addSubview(self.avatarImageView)
        self.addSubview(self.avatarLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.statusTextField)
        self.addSubview(self.statusButton)
                
        [
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            self.avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor,  constant: self.defaultMargin),
            self.avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: self.defaultMargin),
            
            self.avatarLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: self.defaultMargin),
            self.avatarLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            self.avatarLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -self.defaultMargin),
            
            self.statusLabel.bottomAnchor.constraint(equalTo: self.statusTextField.topAnchor, constant: -5.0),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.avatarLabel.leadingAnchor),
            self.statusLabel.trailingAnchor.constraint(equalTo: self.avatarLabel.trailingAnchor),
            
            self.statusTextField.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -self.defaultMargin),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.avatarLabel.leadingAnchor),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.avatarLabel.trailingAnchor),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.statusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: self.defaultMargin),
            self.statusButton.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor),
            self.statusButton.trailingAnchor.constraint(equalTo: self.avatarLabel.trailingAnchor),
            self.statusButton.heightAnchor.constraint(equalToConstant: 50),
            self.statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -self.defaultMargin)
        ].forEach{ $0.isActive = true}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // перегруженный конструктор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupComponents()
    }
}



