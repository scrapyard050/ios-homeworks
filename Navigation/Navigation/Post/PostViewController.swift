//
//  PostViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 20.10.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String?
    
     init(post:Post) {
         self.titlePost = post.title
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func tappedInfoButton(sender: UIButton) {
        let infoControllerName =  String(describing: InfoViewController.self)
        NSLog("Go to %@", infoControllerName)
        self.present(InfoViewController(), animated: true) {
            NSLog("Controller %@ is shown", infoControllerName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        self.title = self.titlePost
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(self.tappedInfoButton))
    }

}
