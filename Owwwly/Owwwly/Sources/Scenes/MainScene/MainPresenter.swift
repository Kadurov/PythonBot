import Foundation

public protocol MainPresentationLogic {
    
    typealias Event = Main.Event
    
    func presentSceneDidUpdate(response: Event.SceneDidUpdate.Response)
    func presentSceneDidUpdateSync(response: Event.SceneDidUpdateSync.Response)
}

extension Main {
    
    public typealias PresentationLogic = MainPresentationLogic
    
    @objc(MainPresenter)
    public class Presenter: NSObject {
        
        public typealias Event = Main.Event
        public typealias Model = Main.Model
        
        // MARK: - Private properties
        
        private let presenterDispatch: PresenterDispatch
        
        // MARK: -
        
        public init(presenterDispatch: PresenterDispatch) {
            self.presenterDispatch = presenterDispatch
        }
    }
}

// MARK: - Private methods

private extension Main.Presenter {
    
    func sceneViewModel(
        from sceneModel: Model.SceneModel
    ) -> Model.SceneViewModel {
        
        return .init()
    }
}

extension Main.Presenter: Main.PresentationLogic {
    
    public func presentSceneDidUpdate(response: Event.SceneDidUpdate.Response) {
        let viewModel: Event.SceneDidUpdate.ViewModel = .init(
            viewModel: sceneViewModel(from: response.sceneModel),
            animated: response.animated
        )
        presenterDispatch.display { (displayLogic) in
            displayLogic.displaySceneDidUpdate(viewModel: viewModel)
        }
    }

    public func presentSceneDidUpdateSync(response: Event.SceneDidUpdateSync.Response) {
        let viewModel: Event.SceneDidUpdateSync.ViewModel = .init(
            viewModel: sceneViewModel(from: response.sceneModel),
            animated: response.animated
        )
        presenterDispatch.displaySync { (displayLogic) in
            displayLogic.displaySceneDidUpdateSync(viewModel: viewModel)
        }
    }
}
