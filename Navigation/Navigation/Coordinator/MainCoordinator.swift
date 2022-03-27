import UIKit

/// @brief Базовый координатор первого уровня
class MainCoordinator: BaseCoordinator, CoordinatableProtocol {
    // MARK: Public properties
    var navigationController: UINavigationController?
    
    // MARK: Private properties
    private var rootWindow: UIWindow?
    private lazy var tab: UITabBarController = {
        let tab = UITabBarController()
        return tab
    }()
    
    // MARK: Constructor
    init(rootWindow: UIWindow? ) {
        self.rootWindow = rootWindow
    }
    
    // MARK: Public methods
    /// @brief Настройка цепочки координаторов и главного окна
    func start() {
        self.prepareFeedCoordinator()
        self.prepareProfileCoordinator()
        self.prepareTabs()
        
        // выставляем рутовый контроллер и делаем окно видимым
        self.rootWindow?.rootViewController = self.tab
        self.rootWindow?.makeKeyAndVisible()
    }
    
    // MARK: Private methods
    private func prepareFeedCoordinator() {
        let feed = FeedViewController()
        let navigation = UINavigationController(rootViewController: feed)
        let coordinator = FeedCoordinator(navigationController: navigation)
        feed.coordinator = coordinator
        self.addCoordinator(child: coordinator)
    }
    
    private func prepareProfileCoordinator() {
        let login = LogInViewController()
        login.delegate = MyLoginFactory().factoryMethod()
        let navigation = UINavigationController(rootViewController: login)
        let coordinator = ProfileCoordinator(navigationController: navigation)
        login.coordinator = coordinator
        self.addCoordinator(child: coordinator)
    }
    
    private func prepareTabs() {
        var tabBarViewControllers: [UIViewController] = []
        self.coordinators.forEach {
            $0.start()
            guard let navigation = $0.navigationController else {
                return
            }
            
            tabBarViewControllers.append(navigation)
        }
        
        self.tab.setViewControllers(tabBarViewControllers, animated: true)
    }
    
}
