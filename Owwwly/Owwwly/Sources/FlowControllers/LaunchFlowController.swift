import UIKit

class LaunchFlowController: BaseFlowController {

    // MARK: - Private properties
    
    private let navigationController: NavigationControllerProtocol

    // MARK: -

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
    
    // MARK: - Overridden
    
    override func showBlockingProgress() {
        self.navigationController.showProgress()
    }
    
    override func hideBlockingProgress() {
        self.navigationController.hideProgress()
    }
    
    // MARK: - Public
    
    func start(animated: Bool) {
        showMainFlow()
    }
}

private extension LaunchFlowController {
    
    func startFrom(vcs: [UIViewController], animated: Bool) {
        self.navigationController.setViewControllers(vcs, animated: animated)
    }
    
    func showMainFlow() {
        let flow = setupMainFlow()
        flow.run(showRootScreen: nil, animated: true)
        currentFlowController = flow
    }
    
    func setupMainFlow(
    ) -> MainFlowController {
        let mainFlow: MainFlowController = .init(
            appController: appController,
            flowControllerStack: flowControllerStack,
            rootNavigation: rootNavigation,
            navigationController: navigationController
        )
        
        return mainFlow
    }
}
