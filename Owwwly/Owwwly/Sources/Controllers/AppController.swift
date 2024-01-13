import UIKit

protocol AppControllerProtocol: AnyObject {
    
    func addUserAcivity(subscriber: UserActivitySubscriber)
    func removeUserAcivity(subscriber: UserActivitySubscriber)
    
    func getLaunchOptions() -> [UIApplication.LaunchOptionsKey: Any]?
    func launchOptionsUrlHandled(url: URL)
    func getLastUserActivityWebLink() -> URL?
    func lastUserActivityWebLinkHandled(url: URL)
    
    func addOpenURL(subscriber: OpenURLSubscriber)
    func removeOpenURL(subscriber: OpenURLSubscriber)
}

class AppController {
    
    // MARK: - Public properties
    
    let rootNavigation: RootNavigationProtocol
    
    // MARK: - Private properties
    
    let flowControllerStack: FlowControllerStack

    private let navigationController: NavigationControllerProtocol = NavigationController()
    
    private var currentFlowController: FlowControllerProtocol?
    
    private var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    internal var lastUserActivityURL: URL?
    internal var userActivitySubscribers = [UserActivitySubscriber]()
    internal var lastOpenURL: URL?
    internal var openURLSubscribers = [OpenURLSubscriber]()
    private var unauthorizedSignOutInitiated: Bool = false
    
    // MARK: -
    
    init(
        rootNavigation: RootNavigationProtocol,
        apiConfigurationModel: APIConfigurationModel?,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) {
        
        self.rootNavigation = rootNavigation
        self.launchOptions = launchOptions
        
        self.flowControllerStack = FlowControllerStack(
            apiConfigurationModel: apiConfigurationModel,
            settingsManager: SettingsManager()
        )

        self.flowControllerStack.updateWith(
            apiConfigurationModel: apiConfigurationModel,
            settingsManager: self.flowControllerStack.settingsManager
        )
    }
    
    // MARK: - Public

    func onRootDidAppear() {
        self.runLaunchFlow(animated: false)
    }
    
    func applicationContinue(
        userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
        ) -> Bool {
        
        return self.handle(userActivity: userActivity)
    }
    
    func applicationDidEnterBackground() {
        self.currentFlowController?.applicationDidEnterBackground()
    }
    
    func applicationWillEnterForeground() {
        self.currentFlowController?.applicationWillEnterForeground()
    }
    
    func applicationDidBecomeActive() {
        self.currentFlowController?.applicationDidBecomeActive()
    }
    
    func applicationWillResignActive() {
        self.currentFlowController?.applicationWillResignActive()
    }
    
    // MARK: - Private
    
    private func runLaunchFlow(animated: Bool) {
        
        rootNavigation.setRootContent(navigationController, transition: .fade, animated: false)
        
        let launchFlowController = LaunchFlowController(
            appController: self,
            flowControllerStack: self.flowControllerStack,
            rootNavigation: self.rootNavigation,
            navigationController: navigationController
        )
        self.currentFlowController = launchFlowController
        launchFlowController.start(animated: animated)
    }
}

extension AppController: AppControllerProtocol {
    
    func getLaunchOptions() -> [UIApplication.LaunchOptionsKey: Any]? {
        return self.launchOptions
    }
    
    func launchOptionsUrlHandled(url: URL) {
        self.launchOptions = nil
    }
    
    func getLastUserActivityWebLink() -> URL? {
        return self.lastUserActivityURL
    }
    
    func lastUserActivityWebLinkHandled(url: URL) {
        if self.lastUserActivityURL == url {
            self.lastUserActivityURL = nil
        }
    }
}
