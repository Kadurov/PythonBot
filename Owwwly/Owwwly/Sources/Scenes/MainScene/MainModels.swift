import UIKit

public enum Main {
    
    // MARK: - Typealiases
    
    public typealias DeinitCompletion = ((_ vc: UIViewController) -> Void)?
    
    // MARK: -
    
    public enum Model {}
    public enum Event {}
}

// MARK: - Models

extension Main.Model {
    
    public struct SceneModel { }

    public struct SceneViewModel { }
}

// MARK: - Events

extension Main.Event {
    
    public typealias Model = Main.Model
    
    // MARK: -
    
    public enum ViewDidLoad {
        public struct Request {}
    }

    public enum ViewDidLoadSync {
        public struct Request {}
    }

    public enum SceneDidUpdate {
        public struct Response {
            let sceneModel: Model.SceneModel
            let animated: Bool
        }

        public struct ViewModel {
            let viewModel: Model.SceneViewModel
            let animated: Bool
        }
    }

    public enum SceneDidUpdateSync {
        public struct Response {
            let sceneModel: Model.SceneModel
            let animated: Bool
        }

        public struct ViewModel {
            let viewModel: Model.SceneViewModel
            let animated: Bool
        }
    }
}
