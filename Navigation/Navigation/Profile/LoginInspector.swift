//
//  LoginInspector.swift
//  Navigation
//
//  Created by Антон Соколов on 13.03.2022.
//

import Foundation

protocol LoginFactory: AnyObject {
    func factoryMethod() -> LoginInspector
}

class MyLoginFactory : LoginFactory {
    func factoryMethod() -> LoginInspector {
        return LoginInspector()
    }
}

// делегат для проверки введенного логина и пароля
class LoginInspector : LoginViewControllerDelegate {
    func checker(login: String, passwd: String) -> Bool {
        return Checker.shared.checker(login: login, passwd: passwd)
    }
}
