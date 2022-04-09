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
    
    func user(name: String) throws  -> User {
        if user.name != name {
            throw UserError.userNotFound
        }
       
        return self.user
    }
    
    
}
