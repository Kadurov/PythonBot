import Foundation

public protocol MainBusinessLogic {
    
    typealias Event = Main.Event
    
    func onViewDidLoad(request: Event.ViewDidLoad.Request)
    func onViewDidLoadSync(request: Event.ViewDidLoadSync.Request)
}

extension Main {
    
    public typealias BusinessLogic = MainBusinessLogic
    
    @objc(MainInteractor)
    public class Interactor: NSObject {
        
        public typealias Event = Main.Event
        public typealias Model = Main.Model
        
        // MARK: - Private properties
        
        private let presenter: PresentationLogic
        private var sceneModel: Model.SceneModel
        
        // MARK: -
        
        public init(presenter: PresentationLogic) {
            self.presenter = presenter
            self.sceneModel = .init()
        }
    }
}

// MARK: - Private methods

private extension Main.Interactor {

    func presentSceneDidUpdate(animated: Bool) {
        let response: Event.SceneDidUpdate.Response = .init(
            sceneModel: sceneModel,
            animated: animated
        )
        presenter.presentSceneDidUpdate(response: response)
    }

    func presentSceneDidUpdateSync(animated: Bool) {
        let response: Event.SceneDidUpdateSync.Response = .init(
            sceneModel: sceneModel,
            animated: animated
        )
        presenter.presentSceneDidUpdateSync(response: response)
    }
}

extension Main.Interactor: Main.BusinessLogic {
    
    public func onViewDidLoad(request: Event.ViewDidLoad.Request) {}

    public func onViewDidLoadSync(request: Event.ViewDidLoadSync.Request) {
        presentSceneDidUpdateSync(animated: false)
    }
}
