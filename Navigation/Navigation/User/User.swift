//
//  User.swift
//  Navigation
//
//  Created by Антон Соколов on 13.02.2022.
//

import Foundation

protocol UserService {
    func user(name: String) -> User?
}

/// модель пользователя
class User {
    var name:String
    var avatar: String
    var status: String
    init( name: String, avatar: String, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
      
    }
}
