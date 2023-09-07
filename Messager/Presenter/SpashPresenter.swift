//
//  SpashPresenter.swift
//  Messager
//
//  Created by Kim Phong on 04/07/2023.
//

import Foundation

protocol SplashView: CommonViewProtocol {}

protocol SplashPresenterProtocol: CommonPresenterProtocol {
    func checkLogin()
}

class SplashPresenter: CommonPresenter {
    var router: SplashWireFrame!

    fileprivate weak var splashView: SplashView? {
        return view as! SplashView?
    }

    init(router: SplashWireFrame) {
        self.router = router
    }
}

extension SplashPresenter: SplashPresenterProtocol {
    func checkLogin() {
        if UserService.getUserStatus() == UserStatus.member.rawValue {
            router.moveToHome()
        } else  {
            router.moveToLogin()
        }
    }
}
