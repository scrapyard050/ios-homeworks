//
//  TestUserService.swift
//  Navigation
//
//  Created by Антон Соколов on 13.02.2022.
//

import Foundation

class TestUserService: UserService {
    
    // тестовые значения передаем через конструктор
    private let user = User(name: "Alex",
                            avatar: Constants.infoNotDefined,
                            status: Constants.infoNotDefined)
    
    func user(name: String) throws ->  User {
        return user
    }
}
