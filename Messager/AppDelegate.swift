//
//  AppDelegate.swift
//  Messager
//
//  Created by Kim Phong on 16/06/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var oidcClient = AnyOidcClient(FirebaseClient.default)
    private let userService = UserService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        moveToSplash()

        IQKeyboardManager.shared.enable = true

        oidcClient.addStateDidChangeListener { [weak self] authStateListener, authUser in
            self?.oidcClient.removeStateDidChangeListener(authStateListener: authStateListener)
            if authUser == nil {
                GlobalSettings.userStatus = UserStatus.none.rawValue
                GlobalSettings.emailAddress = ""
                self?.userService.removeUserCaches()
            }
        }

        return true
    }
}

private extension AppDelegate {
    private func moveToSplash() {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Splash") as! SplashViewController
        viewController.presenter = SplashPresenter(router: SplashRouter(view: viewController))
        viewController.modalTransitionStyle = .crossDissolve
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
