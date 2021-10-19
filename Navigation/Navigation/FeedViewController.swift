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
    
    func setupPostButton () {
        // создаем кнопку
        let postButton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 60))
        // выставляем заголовки и цвет
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = UIColor.blue
        // добавляем обработку события нажатия на клавишу
        postButton.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        // в условии задачи не сказало как располагать кнопку
        // поэтому поставил компонент по середине, чтобы не перегружать код констрейнтами и анчорами код
        postButton.center = self.view.center
        self.view.addSubview(postButton)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupPostButton()
    }
}
