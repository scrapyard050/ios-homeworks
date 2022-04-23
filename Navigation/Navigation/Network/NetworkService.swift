//
//  File.swift
//  Navigation
//
//  Created by Антон Соколов on 17.04.2022.
//

import Foundation

/// @brief Сервис для выполнения сетевых задач
class NetworkService {
    private enum AppConfiguration: String {
        case people = "https://swapi.dev/api/people/8"
        case starships = "https://swapi.dev/api/starships/3"
        case planets = "https://swapi.dev/api/planets/5"
    }

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
    
    /// @brief Запрос на получение данные, ответ отадем сразу же в декодер, здесь не обрабатываем
    func sendRequest(url: String, responseHandler: @escaping CompletionHttpResponseHandler ) {
        self.sendRequestImpl(url: url, responseHandler: responseHandler)
    }
    
    /// @todo чтобы не сломать предыдующую домашку сохранил сигнатуру вызова
    ///  Реализацию вынес в отдельный класс, здесь идет только обработка ответа
    func sendRequest(url: String) {
        self.sendRequestImpl(url: url, responseHandler: { result in
            switch result {
            case .success(let data):
                print(HttpDecoder.shared.decodeData(mode: .simple, data: data))
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
    
    
    /// @brief отправка запроса на указанный url
    /// @todo в задачи нет условия работы с конфигурациями или кастомными запросами
    /// поэтому создал дефолтную сессию через синглтон
    /// Декодирование данных перенесем на уровень модели
    private func sendRequestImpl(url: String, responseHandler: @escaping CompletionHttpResponseHandler ) {
        guard let url = URL(string: url) else {
            responseHandler(.failure(.badFormatRequest))
            return
        }
        
        // Создаем сессию и ставим задачу на выполнения
        // в callback обрабатываем ответ
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                responseHandler(.failure(.badAnswer))
                return
            }
            
            guard let data = data else {
                responseHandler(.failure(.noData))
                return
            }
            responseHandler(.success(data))
        }

        session.resume()
        
    }
}

