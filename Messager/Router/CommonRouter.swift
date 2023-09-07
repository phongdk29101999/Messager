//
//  CommonRouter.swift
//  Messager
//
//  Created by Kim Phong on 04/07/2023.
//

import Foundation
import UIKit

class CommonRouter {
    weak var view: BaseViewController!

    var authStoryboard: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: nil)
    }

    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    var spashStoryboard: UIStoryboard {
        return UIStoryboard(name: "Splash", bundle: nil)
    }

    init(view: BaseViewController!) {
        self.view = view
    }

    func createViewController<T: UIViewController>(storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

/// Routing of launch flow
protocol LaunchWireFrame {
    func moveToHome()
    func moveToLogin()
}

class LaunchRouter: CommonRouter, LaunchWireFrame {
    func moveToLogin() {
        let viewController: LoginViewController = createViewController(storyboard: authStoryboard, identifier: "Login")
        viewController.presenter = AuthPresenter(router: AuthRouter(view: viewController), authService: AuthService(), userService: UserService())
        viewController.modalTransitionStyle = .crossDissolve
        view.present(viewController, animated: true, completion: nil)
    }

    func moveToHome() {
        let tabBarController: UITabBarController = createViewController(storyboard: mainStoryboard, identifier: "TopView")
        tabBarController.modalTransitionStyle = .crossDissolve
        view.present(tabBarController, animated: true, completion: nil)
    }
}
