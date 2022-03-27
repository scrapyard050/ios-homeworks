//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Антон Соколов on 26.03.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: CoordinatableProtocol {
    var navigationController: UINavigationController?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController?.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(named: "profile"), selectedImage: nil)
    }
    
    func login() {
        
    }
    
}
