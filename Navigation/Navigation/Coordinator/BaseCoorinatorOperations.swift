import Foundation

/// @brief Класс описывает базовые операции для работы с координатором
class BaseCoordinator {
    
    /// @brief список дочерних координаторов
    var coordinators: [CoordinatableProtocol] = []
    
    /// @brief  добавление дочернего координатора
    func addCoordinator( child: CoordinatableProtocol) {
        for coorinator in coordinators {
            if coorinator === child {
                return
            }
        }
        
        self.coordinators.append(child)
    }
    
    /// @brief  Удаление дочернего координатора
    func removeCoordinator( child: CoordinatableProtocol) {
        guard !coordinators.isEmpty else {
            return
        }
        
        self.coordinators = self.coordinators.filter{ $0 !== child}
    }
}
