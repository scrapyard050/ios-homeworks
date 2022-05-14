//
//  DocumentsCoordinator.swift
//  Navigation
//
//  Created by Антон Соколов on 14.05.2022.
//

import Foundation
import UIKit

class DocumentsCoordinator:CoordinatableProtocol {
    var navigationController: UINavigationController?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController?.tabBarItem = UITabBarItem(title: "DOCUMENTS", image: UIImage(named: "docs"), selectedImage: nil)
    }

}
