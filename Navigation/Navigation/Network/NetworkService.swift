//
//  File.swift
//  Navigation
//
//  Created by Антон Соколов on 17.04.2022.
//

import Foundation


enum AppConfiguration: String {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}

/// @brief Сервис для выполнения сетевых задач
struct NetworkService {
    static var shared: NetworkService = {
        let instance = NetworkService()
        return instance
    }()
    private init() {}
    
    /// @brief  Определение url для подключения
    func detectUrlForConnection() -> String {
        var appConfiguration: AppConfiguration {
            switch Int.random(in: 0...2) {
            case 0:
                return .people
            case 1:
                return .starships
            case 2:
                return .planets
                // по дефолту вернем кейс для url people
            default:
                return .people
            }
        }
        return appConfiguration.rawValue
    }
    
    /// @brief отправка запроса на указанный url
    /// @todo в задачи нет условия работы с конфигурациями или кастомными запросами
    /// поэтому создал дефолтную сессию через синглтон
    func sendRequest(url: String) {
        guard let url = URL(string: url) else {
            print("URL is nil")
            return
        }
        // Создаем сессию и ставим задачу на выполнения
        // в callback обрабатываем ответ
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            /// @todo поскольку никаких действий на главном потоке делать не нужно то обрабатываем ответ  в бэкграунде
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Http code: \(httpResponse.statusCode)")
                return
            }
            
            guard let data = data else {
                print("Data is nil")
                return
            }
            
            guard let serverData = String(data: data, encoding: .utf8) else {
                print("Error parse data from server")
                return
            }
            
            print("Server data: \(serverData)")
        }
        session.resume()
    }
}

