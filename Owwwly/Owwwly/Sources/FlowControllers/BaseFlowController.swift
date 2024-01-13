import UIKit

protocol FlowControllerProtocol {
    
    var currentFlowController: FlowControllerProtocol? { get set }
    
    // MARK: - App life cycle
    
    func applicationDidEnterBackground()
    func applicationWillEnterForeground()
    func applicationDidBecomeActive()
    func applicationWillResignActive()
    
    func showBlockingProgress()
    func hideBlockingProgress()
}

class FlowControllerStack {
    
    // MARK: - APIs
    
    var apiConfigurationModel: APIConfigurationModel?
    var settingsManager: SettingsManagerProtocol
    
    // MARK: -
    
    init(
        apiConfigurationModel: APIConfigurationModel?,
        settingsManager: SettingsManagerProtocol
        ) {
        
        self.apiConfigurationModel = apiConfigurationModel
        self.settingsManager = settingsManager
    }
    
    func updateWith(
        apiConfigurationModel: APIConfigurationModel?,
        settingsManager: SettingsManagerProtocol
        ) {

        self.apiConfigurationModel = apiConfigurationModel
        self.settingsManager = settingsManager
    }
}

class BaseFlowController: FlowControllerProtocol {
    
    var currentFlowController: FlowControllerProtocol?
    
    // MARK: - Public properties
    
    let appController: AppControllerProtocol
    let flowControllerStack: FlowControllerStack
    let rootNavigation: RootNavigationProtocol
    
    // MARK: - Private properties
    
    private var inputTFAText: String = ""
        
    // MARK: -
    
    init(
        appController: AppControllerProtocol,
        flowControllerStack: FlowControllerStack,
        rootNavigation: RootNavigationProtocol
        ) {
        
        self.appController = appController
        self.flowControllerStack = flowControllerStack
        self.rootNavigation = rootNavigation
    }
    
    // MARK: - Public
    
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
    
    func showBlockingProgress() {

    }
    
    func hideBlockingProgress() {
        
    }
}
