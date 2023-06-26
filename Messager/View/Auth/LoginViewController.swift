//
//  LoginViewController.swift
//  Messager
//
//  Created by Kim Phong on 16/06/2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTitleLabel: DesignableLabel!
    @IBOutlet weak var emailLabel: DesignableLabel!
    @IBOutlet weak var passwordLabel: DesignableLabel!
    @IBOutlet weak var signUpLabel: DesignableLabel!
    @IBOutlet weak var repeatPasswordLabel: DesignableLabel!

    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var repeatPasswordTextField: UnderlineTextField!

    @IBOutlet weak var signUpButton: DesignableButton!
    @IBOutlet weak var loginButton: RoundButton!
    @IBOutlet weak var forgotPasswordButton: DesignableButton!
    @IBOutlet weak var resendEmailButton: DesignableButton!

    @IBOutlet weak var loginFormContainer: UIView!

    var isLogin: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        updateUIFor(login: isLogin)
        setupTextFieldDelegate()
    }

    @IBAction func onPressLoginButton(_ sender: UIButton) {
    }

    @IBAction func onPressForgotPassword(_ sender: Any) {
    }

    @IBAction func onPressResendEmail(_ sender: Any) {
    }

    @IBAction func onPressSignUp(_ sender: UIButton) {
        isLogin.toggle()
        updateUIFor(login: isLogin)
    }

    private func setupTextFieldDelegate() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderLabels(for: textField)
    }

    private func updatePlaceholderLabels(for textField: UITextField) {
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

    private func updateUIFor(login: Bool) {
        loginButton.setTitle(login ? "Login" : "Register", for: .normal)
        signUpButton.setTitle(login ? "SignUp" : "Login", for: .normal)
        signUpLabel.text = login ? "Don't have an account ?" : "Have an account?"
        loginTitleLabel.text = login ? "Login" : "Register"
        
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordLabel.isHidden = login
            self.repeatPasswordTextField.isHidden = login
        }

        loginFormContainer.snp.remakeConstraints {
            $0.bottom.equalTo(login ? self.passwordTextField.snp.bottom : self.repeatPasswordTextField.snp.bottom)
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.focusNext()
    }
}

