//
//  LoginViewController.swift
//  Messager
//
//  Created by Kim Phong on 16/06/2023.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    override var screenName: String {
        return "Login"
    }

    @IBOutlet private var loginTitleLabel: DesignableLabel!
    @IBOutlet private var emailLabel: DesignableLabel!
    @IBOutlet private var passwordLabel: DesignableLabel!
    @IBOutlet private var signUpLabel: DesignableLabel!
    @IBOutlet private var repeatPasswordLabel: DesignableLabel!

    @IBOutlet private var emailTextField: DesignableTextField!
    @IBOutlet private var passwordTextField: DesignableTextField!
    @IBOutlet private var repeatPasswordTextField: UnderlineTextField!

    @IBOutlet private var signUpButton: DesignableButton!
    @IBOutlet private var loginButton: RoundButton!
    @IBOutlet private var forgotPasswordButton: DesignableButton!
    @IBOutlet private var resendEmailButton: DesignableButton!

    @IBOutlet private var loginFormContainer: UIView!

    var presenter: AuthPresenterProtocol!
    private var isLogin: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        setupTextFieldDelegate()
        presenter.attachView(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func onPressLoginButton(_ sender: UIButton) {
        if presenter.validate(email: emailTextField.text!, password: passwordTextField.text!, repeatPassword: repeatPasswordTextField.text ?? "") {
            isLogin ? login() : register()
        }
    }

    @IBAction func onPressForgotPassword(_ sender: Any) {
        if emailTextField.hasText {
            presenter.resetPassword(email: emailTextField.text!)
        } else {
            showFailed(Message.warningRequireEmail)
        }
    }

    @IBAction func onPressResendEmail(_ sender: Any) {
        presenter.resendEmailVerification()
        resendEmailButton.isHidden = true
    }

    @IBAction func onPressSignUp(_ sender: UIButton) {
        isLogin.toggle()
        updateUI()
    }

    private func setupTextFieldDelegate() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderLabels(for: textField)
    }
}

extension LoginViewController {
    func updateUI() {
        repeatPasswordTextField.text = ""
        emailLabel.text = ""
        passwordLabel.text = ""
        repeatPasswordLabel.text = ""
        loginButton.setTitle(isLogin ? "Login" : "Register", for: .normal)
        signUpButton.setTitle(isLogin ? "SignUp" : "Login", for: .normal)
        signUpLabel.text = isLogin ? "Don't have an account ?" : "Have an account?"
        loginTitleLabel.text = isLogin ? "Login" : "Register"
        resendEmailButton.isHidden = true

        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordLabel.isHidden = self.isLogin
            self.repeatPasswordTextField.isHidden = self.isLogin
        }

        loginFormContainer.snp.remakeConstraints {
            $0.bottom.equalTo(isLogin ? self.passwordTextField.snp.bottom : self.repeatPasswordTextField.snp.bottom)
        }
        updatePlaceholderLabels(for: emailTextField)
        updatePlaceholderLabels(for: passwordTextField)
        if !isLogin {
            updatePlaceholderLabels(for: repeatPasswordTextField)
        }
        updateLoginButton()
    }

    func updateLoginButton() {
        let isEmptyRepeatPasswordTextField = !isLogin && !repeatPasswordTextField.hasText
        if !emailTextField.hasText || !passwordTextField.hasText || isEmptyRepeatPasswordTextField {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightBlue?.withAlphaComponent(0.2)
        } else {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .lightBlue
        }
    }

    func updatePlaceholderLabels(for textField: UITextField) {
        switch textField {
        case emailTextField:
            emailLabel.text = textField.hasText ? "Email" : ""
        case passwordTextField:
            passwordLabel.text = textField.hasText ? "Password" : ""
        case repeatPasswordTextField:
            repeatPasswordLabel.text = textField.hasText ? "Repeat Password" : ""
        default:
            break
        }
    }

    func login() {
        presenter.login(email: emailTextField.text!, password: passwordTextField.text!)
    }

    func register() {
        presenter.register(email: emailTextField.text!, password: passwordTextField.text!)
    }
}

// MARK: - UITextField
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (isLogin && textField.tag == 2) || (!isLogin && textField.tag == 3) {
            view.endEditing(true)
            return true
        }
        return textField.focusNext()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButton()
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (isLogin && textField.tag == 1) {
            resendEmailButton.isHidden = true
        }
    }
}

extension LoginViewController: LoginView {
    func showResendEmailButton() {
        resendEmailButton.isHidden = false
    }

    func moveToLogin() {
        isLogin = true
        updateUI()
    }
}

