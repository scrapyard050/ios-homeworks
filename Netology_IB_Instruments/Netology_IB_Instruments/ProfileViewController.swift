//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Антон Соколов on 15.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewName = String(describing: ProfileView.self)
        guard let profileView = Bundle.main.loadNibNamed(viewName, owner: nil, options: nil)?.first as? ProfileView else {
            return
        }
        
        profileView.frame = CGRect(x: 5, y: 100, width: self.view.bounds.width - 10, height: 350)
        self.view.addSubview(profileView)
        
        // @todo задание значений для контроллов решил вынести в отдельный метод, чтобы не перегружать контроллер
        profileView.setup()

    }
    



}
