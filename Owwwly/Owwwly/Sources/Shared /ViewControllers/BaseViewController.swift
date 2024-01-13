import UIKit

public class BaseViewController: UIViewController {

    // MARK: - Overridden

    public override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    deinit {
        print(.deinit(object: self))
    }
}

extension BaseViewController: UIGestureRecognizerDelegate { }
