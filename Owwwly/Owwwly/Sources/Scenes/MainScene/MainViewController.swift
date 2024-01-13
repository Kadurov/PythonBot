import UIKit

public protocol MainDisplayLogic: AnyObject {
    
    typealias Event = Main.Event
    
    func displaySceneDidUpdate(viewModel: Event.SceneDidUpdate.ViewModel)
    func displaySceneDidUpdateSync(viewModel: Event.SceneDidUpdateSync.ViewModel)
}

extension Main {
    
    public typealias DisplayLogic = MainDisplayLogic
    
    @objc(MainViewController)
    public class ViewController: UIViewController {
        
        public typealias Event = Main.Event
        public typealias Model = Main.Model
        
        // MARK: - Private properties
        
        private var backgroundColor: UIColor { Theme.Colors.mainBackgroundColor }
        
        // MARK: -
        
        deinit {
            self.onDeinit?(self)
        }
        
        // MARK: - Injections
        
        private var interactorDispatch: InteractorDispatch?
        private var routing: Routing?
        private var onDeinit: DeinitCompletion = nil
        
        public func inject(
            interactorDispatch: InteractorDispatch?,
            routing: Routing?,
            onDeinit: DeinitCompletion = nil
            ) {
            
            self.interactorDispatch = interactorDispatch
            self.routing = routing
            self.onDeinit = onDeinit
        }
        
        // MARK: - Overridden
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            setup()
            
            let request = Event.ViewDidLoad.Request()
            self.interactorDispatch?.sendRequest { businessLogic in
                businessLogic.onViewDidLoad(request: request)
            }
            
            let requestSync = Event.ViewDidLoadSync.Request()
            self.interactorDispatch?.sendSyncRequest { businessLogic in
                businessLogic.onViewDidLoadSync(request: requestSync)
            }
        }
    }
}

// MARK: - Private methods

private extension Main.ViewController {
    
    func setup() {
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = backgroundColor
        let myView: UIView = .init()
        myView.backgroundColor = .red
        view.addSubview(myView)
        myView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300.0)
        }
    }
    
    func setup(with sceneViewModel: Model.SceneViewModel, animated: Bool) {
        
        return
    }
}

extension Main.ViewController: Main.DisplayLogic {
    
    public func displaySceneDidUpdate(viewModel: Event.SceneDidUpdate.ViewModel) {
        setup(with: viewModel.viewModel, animated: viewModel.animated)
    }
    
    public func displaySceneDidUpdateSync(viewModel: Event.SceneDidUpdateSync.ViewModel) {
        setup(with: viewModel.viewModel, animated: viewModel.animated)
    }
}
