import UIKit

class MainFlowController: BaseFlowController {
    
    typealias OnSignOut = () -> Void
    // MARK: - Private properties

    private let navigationController: NavigationControllerProtocol
    init(
        appController: AppControllerProtocol,
        flowControllerStack: FlowControllerStack,
        rootNavigation: RootNavigationProtocol,
        navigationController: NavigationControllerProtocol
    ) {
        
        self.navigationController = navigationController
        
        super.init(
            appController: appController,
            flowControllerStack: flowControllerStack,
            rootNavigation: rootNavigation
        )
    }
}

// MARK: - Private methods

private extension MainFlowController {
    
    func setupMainScreen(
    ) -> Main.ViewController {
        
        let viewController = Main.ViewController()
        
        let routing: Main.Routing = .init()
        
        Main.Configurator.configure(
            viewController: viewController,
            routing: routing
        )
        
        return viewController
    }
}

// MARK: - Public methods

extension MainFlowController {

    func run(
        showRootScreen: ((_ vc: RootContentProtocol) -> Void)?,
        animated: Bool
    ) {
        let vc: UIViewController = self.setupMainScreen()
        self.navigationController.setViewControllers([vc], animated: false)
    }
}
