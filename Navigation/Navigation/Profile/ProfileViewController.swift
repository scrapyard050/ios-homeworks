//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 19.10.2021.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func tapButton()
}

class ProfileViewController: UIViewController, UINavigationBarDelegate {
   
    var profile: ProfileHeaderView?
    
    /// @brief Создаем стандарный навигейшен бар с заголовком
    func createNavigationBar() {
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50));
        let barItem = UINavigationItem(title: "Profile")
        bar.setItems([barItem], animated: false)
        self.view.addSubview(bar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar()
        self.view.backgroundColor = .lightGray
        self.profile = ProfileHeaderView(frame: .zero, withDelegate: self)
        guard let profile = self.profile else { return }
        self.view.addSubview(profile)
    }
    
    override func viewWillLayoutSubviews() {
        guard let profile = self.profile else { return }
        profile.frame = self.view.frame
        profile.addItems()
    }

}

extension ProfileViewController: ProfileViewControllerDelegate {
    func tapButton() {
        NSLog("Button is tapped")
    }
}
