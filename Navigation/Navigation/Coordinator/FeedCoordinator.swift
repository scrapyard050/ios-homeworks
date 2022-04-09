//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Антон Соколов on 26.03.2022.
//

import Foundation
import UIKit
class FeedCoordinator: CoordinatableProtocol {
    var navigationController: UINavigationController?
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController?.tabBarItem = UITabBarItem(title: "FEED", image: UIImage(named: "feed"), selectedImage: nil)
    }

}
