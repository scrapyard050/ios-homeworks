//
//  MyDecoder.swift
//  Navigation
//
//  Created by Антон Соколов on 22.04.2022.
//

import Foundation

enum ModeDecode {
    case simple
    case standartJsonSerialization
    case decodable
}


/// @todo конструктор и перечисление не стал заводить отдельной, поскольку данные и так по полям парсятся без ошибок
struct PlanetInfo: Decodable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
}

/// @brief Реализация декодера, тоже сдедаем через синглтон
class HttpDecoder {
    static var shared: HttpDecoder = {
        let instance = HttpDecoder()
        return instance
    }()
    
    private init() {}
    
    func decodeData(mode: ModeDecode, data: Data) -> String{
        switch mode {
        case .simple:
            return simpleDecode(data: data)
        
        case .standartJsonSerialization:
            return standartJsonSerialization(data: data)
       
        case .decodable:
            return decodable(data: data)
        }
    }
    
    private func decodable(data: Data)  -> String {
        do {
            let info = try JSONDecoder().decode(PlanetInfo.self, from: data)
            return info.orbital_period
        }catch let error {
            print(error)
            return "No data"
            }
        }
    }
    
    private func simpleDecode(data: Data) -> String {
        guard let serverData = String(data: data, encoding: .utf8) else {
            return "No data"
        }
        
        return serverData
    }
    
    private func standartJsonSerialization(data: Data) -> String {
        do {
            // в качесте теста выводим значение 1 индекса
            guard let serilalizationData = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [NSDictionary]
            else {
                return "No data"
            }
            
            guard let dict = serilalizationData[0] as? [String: Any]
            else {
                return "No data"
            }
            
            guard let title = dict["title"] as? String
            else {
                return "No data"
            }
            return title
            
        }catch let error {
            print(error)
            return "No data"
        }
    }
