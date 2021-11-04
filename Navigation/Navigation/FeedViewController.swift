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
    
    
    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        self.view.addSubview(stackView)
        
        // настраиваем констрейнты для отображения stackView по центру по центру
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupPostButton()
    }
}
