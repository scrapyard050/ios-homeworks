//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Антон Соколов on 15.10.2021.
//

import UIKit

class ProfileView: UIView {

    // аватарка
    @IBOutlet weak var avatar: UIImageView!
    // имя города
    @IBOutlet weak var name: UILabel!
    // дата рождения
    @IBOutlet weak var dateOfBirth: UILabel!
    // город
    @IBOutlet weak var city: UILabel!
    // отображение многострочного текста
    @IBOutlet weak var textView: UITextView!
    
    // Настройка параметров
    func setup() {
        
        self.avatar.image = UIImage(named: "Avatar")
        
        self.name.text = "Anton"
        self.name.backgroundColor = UIColor.orange
        
        self.dateOfBirth.text = "03.05.1987"
        self.dateOfBirth.backgroundColor = UIColor.green
        
        self.city.text = "Saint-Petersburg"
        self.city.backgroundColor = UIColor.blue
    }
}
