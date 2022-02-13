//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Антон Соколов on 13.02.2022.
//

import Foundation

class CurrentUserService : UserService {
    var user: User
    init(user: User) {
        self.user = user
    }
    
    func user(name: String) -> User? {
        if user.name == name {
            return user
        }
        return nil
    }
    
    
}
