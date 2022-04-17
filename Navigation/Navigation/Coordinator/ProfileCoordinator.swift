//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Антон Соколов on 26.03.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: CoordinatableProtocol {
    typealias ErrorHandler = (String) -> Void
    var navigationController: UINavigationController?
    var errorHandler: ErrorHandler?
    private var profileModule: ProfileModule
    
  
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.profileModule = ProfileModule(navigationController: navigationController)
        self.profileModule.coordinator = self
        self.profileModule.delegate = MyLoginFactory().factoryMethod()
    }
    
    func start() {
        self.navigationController?.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(named: "profile"), selectedImage: nil)
    }
    
    func login(userName: String?, passwd: String?) {
        self.profileModule.login(userName: userName, passwd: passwd)
    }
    
    func bruteForce(completionHandler: @escaping(Result<String, BruteForceError>) -> Void) {
        self.profileModule.bruteForce(completionHandler: completionHandler)
    }
}
