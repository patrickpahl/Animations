import UIKit

class LightContentNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationController {
    func showDarkNavBar() {
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .white // For bar button items
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

