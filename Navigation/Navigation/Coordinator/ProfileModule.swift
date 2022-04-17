//
//  ProfileModule.swift
//  Navigation
//
//  Created by Антон Соколов on 27.03.2022.
//

import UIKit

class ProfileModule {
    var navigationController: UINavigationController?
    var delegate: LoginViewControllerDelegate?
    var coordinator: ProfileCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func login(userName: String?, passwd: String?) {
        
        guard let userName = userName else {
            self.coordinator?.errorHandler?("User name is nil")
            return
        }
        
        guard !userName.isEmpty else {
            self.coordinator?.errorHandler?("User name is empty")
            return
        }
        
        guard let passwd = passwd else {
            self.coordinator?.errorHandler?("Password is nil")
            return
        }
        
        guard !passwd.isEmpty else {
            self.coordinator?.errorHandler?("Password name is empty")
            return
        }
 
        guard let result =  delegate?.checker(login: userName, passwd: passwd) else {
            self.coordinator?.errorHandler?("Handler for check credention is nil")
            return
        }

        if( !result) {
            self.coordinator?.errorHandler?("Login or password is incorrect")
            return
        }
        
        let currentUserService = CurrentUserService(user: User(name: userName,
                                                                avatar: Constants.infoNotDefined,
                                                                status: Constants.infoNotDefined ) )
        
        // переходим к следующему окну если только прошла проверка введенного логина и пароя
        self.navigationController?.pushViewController(ProfileViewController(userService: currentUserService, userName: userName), animated: true)
    }
    
    
    func bruteForce(completionHandler: @escaping(Result<String, BruteForceError>) -> Void ) {
        let brutForceService = BrutForceService()
        let password = brutForceService.generateRandomPassword()
        guard !password.isEmpty else {
            completionHandler(.failure(.generatedEmptyPassword))
            return
        }
        
        let workItem = DispatchWorkItem {
            brutForceService.bruteForce(passwordToUnlock:password)
        }
        
        // после окончания работы в главном потоке выводим результат в UI
        workItem.notify(queue: DispatchQueue.main) {
            print("Operation Completed")
            completionHandler(.success(brutForceService.passwordData()))
        }
        
        // ставим задачу на исполнение в глобальную очередь
        let task = DispatchQueue.global(qos: .background)
        print("Starting of Brute force password")
        task.async(execute: workItem)
       
    }
    
}
