//
//  AuthPresenter.swift
//  Messager
//
//  Created by Kim Phong on 29/06/2023.
//

import Foundation

typealias OidcClient = AnyOidcClient<FirebaseClient.AuthStateListener, FirebaseClient.AuthUser>

protocol LoginView: CommonViewProtocol {
    func showResendEmailButton()
    func moveToLogin()
}

protocol AuthPresenterProtocol: CommonPresenterProtocol {
    var isLogin: Bool { get }
    var oidcClient: OidcClient { get }
    var authService: AuthServiceProtocol { get }
    var userService: UserServiceProtocol { get }
    func register(email: String, password: String)
    func validate(email: String, password: String, repeatPassword: String) -> Bool
    func login(email: String, password: String)
    func resendEmailVerification()
    func resetPassword(email: String)
}

class AuthPresenter: CommonPresenter, AuthPresenterProtocol {
    fileprivate var loginView: LoginView? {
        return view as! LoginView?
    }
    var router: AuthWireFrame!
    var isLogin: Bool = true
    var oidcClient: OidcClient
    var authService: AuthServiceProtocol
    var userService: UserServiceProtocol

    init(router: AuthWireFrame, oidcClient: OidcClient = AnyOidcClient(FirebaseClient.default), authService: AuthServiceProtocol, userService: UserServiceProtocol) {
        self.router = router
        self.oidcClient = oidcClient
        self.authService = authService
        self.userService = userService
    }

    func login(email: String, password: String) {
        loginView?.startLoading()
        oidcClient.signIn(email: email, password: password) { [weak self] userUid, isEmailVerified, error in
            if error != nil {
                log(error!)
                self?.finishWithFail(error!.localizedDescription)
            } else {
                guard let userUid = userUid, let isEmailVerified = isEmailVerified else {
                    log("UID or isEmailVerified is nil")
                    self?.finishWithFail(Message.failGetUserInfo)
                    return
                }
                self?.userService.saveUserStatus(verifiedEmail: isEmailVerified)
                if !isEmailVerified {
                    log("Email is not verified")
                    self?.finishWithFail(Message.warningVerifyEmail)
                    self?.loginView?.showResendEmailButton()
                    return
                }
                self?.userService.getUser(userId: userUid) { [weak self] result in
                    switch result {
                    case .success(let user):
                        self?.userService.saveUserCache(user)
                        self?.loginView?.finishLoading(completion: {
                            self?.router.moveToHome()
                        })
                    case .failure(let error):
                        log(error)
                        self?.finishWithFail(Message.failGetUserInfo)
                        return
                    }
                }
            }
        }
    }

    func register(email: String, password: String) {
        loginView?.startLoading()
        oidcClient.signUp(email: email, password: password) { [weak self] userId, error in
            if error != nil {
                log(error!)
                self?.finishWithFail(error!.localizedDescription)
            } else {
                guard let userId = userId else {
                    log("UID is nil")
                    self?.finishWithFail(Message.failRegistration)
                    return
                }
                self?.oidcClient.sendEmailVerification { error in
                    if error != nil {
                        log(error!)
                    }
                }
                let user = UserInfo(id: userId, username: email, email: email, pushId: "", avatarLink: "", status: "")
                self?.userService.createUser(user)
                self?.userService.saveUserCache(user)
                self?.userService.saveUserStatus(verifiedEmail: false)
                self?.loginView?.finishLoading(completion: {
                    self?.loginView?.showSuccess(Message.successSendVerificationEmail)
                    self?.loginView?.moveToLogin()
                    self?.loginView?.showResendEmailButton()
                })
            }
        }
    }

    func validate(email: String, password: String, repeatPassword: String) -> Bool {
        if !email.isEmail() {
            loginView?.showError(Message.invalidEmail)
            return false
        }
        if !repeatPassword.isEmpty && password != repeatPassword {
            loginView?.showError(Message.newPasswordMismatch)
            return false
        }
        if !password.isPassword() {
            loginView?.showError(Message.invalidPassword)
            return false
        }
        return true
    }

    func resendEmailVerification() {
        oidcClient.sendEmailVerification { [weak self] error in
            if error != nil {
                log(error!)
                self?.loginView?.showFailed(Message.warningVerifyEmail)
            } else {
                self?.loginView?.showSuccess(Message.successSendVerificationEmail)
            }
        }
    }

    func resetPassword(email: String) {
        oidcClient.resetPassword(email: email) { [weak self] error in
            if error != nil {
                log(error!)
                self?.loginView?.showFailed(error!.localizedDescription)
            } else {
                self?.loginView?.showSuccess(Message.successSendResetPasswordLink)
            }
        }
    }
}
