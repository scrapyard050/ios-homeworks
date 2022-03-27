//
//  FeedViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 19.10.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    // обработчик нажатия кнопки
    @objc func tappedButton(sender: UIButton ) {
        let postVC = PostViewController(post: Post(title: "Post"))
        NSLog("Go to %@", String(describing: PostViewController.self))
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    
  
    /// поскольку макетов нету встроил компоненты в уже в имеющиюся верстку
    private(set)lazy var testMessageLabel: UILabel = {
        let testMessageLabel = UILabel()
        testMessageLabel.text = "Check Result"
        testMessageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        testMessageLabel.textColor = .black
        testMessageLabel.toAutoLayout()
        return testMessageLabel
    }()
    
    private lazy var testMessageTextFiled: UITextField = {
        let testMessageTextFiled = UITextField.init(frame: .zero)
        testMessageTextFiled.placeholder = "Enter message for check"
        testMessageTextFiled.textColor = UIColor.black
        testMessageTextFiled.font = UIFont.systemFont(ofSize: 16)
        testMessageTextFiled.autocapitalizationType = .none
        testMessageTextFiled.isSecureTextEntry = false
        testMessageTextFiled.backgroundColor = .clear
        testMessageTextFiled.textAlignment = .center
        testMessageTextFiled.toAutoLayout()
        return testMessageTextFiled
    }()
    
    let custom = CustomButton(title: "TestMessage", tintColor: UIColor.white);
    private(set) lazy var textMessageHandler = custom
    
    
    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1
        stackView.toAutoLayout()
        return stackView
    }()
    
    func setupPostButton () {
        
        // создаем кнопку
        let postButton1 = UIButton()
        // выставляем заголовки и цвет
        postButton1.setTitle("Post", for: .normal)
        postButton1.backgroundColor = UIColor.blue
        // добавляем обработку события нажатия на клавишу
        postButton1.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        
        let postButton2 = UIButton()
        postButton2.setTitle("Post", for: .normal)
        postButton2.backgroundColor = UIColor.blue
        // добавляем обработку события нажатия на клавишу
        postButton2.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        
        stackView.addArrangedSubview(postButton1)
        stackView.addArrangedSubview(postButton2)
        stackView.addArrangedSubview(self.testMessageLabel)
        stackView.addArrangedSubview(self.testMessageTextFiled)
        stackView.addArrangedSubview(self.textMessageHandler)
        self.view.addSubviews(stackView)
        
        // настраиваем констрейнты для отображения stackView по центру по центру
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupPostButton()
        custom.onButtonTap = { [weak self] in
            guard let message = self?.testMessageTextFiled.text else {
                return
            }
            
            guard !message.isEmpty else {
                print("Test message is empty")
                return
            }
            
            let testModel = TestModel()
            testModel.check(word: message, completionHandler: { succes in
                if(succes) {
                    self?.testMessageLabel.backgroundColor = .green
                    return
                }
                self?.testMessageLabel.backgroundColor = .red
            } )
        }
    }
}
