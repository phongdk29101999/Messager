//
//  BaseViewController.swift
//  Messager
//
//  Created by Kim Phong on 22/06/2023.
//

import Foundation
import UIKit
import ProgressHUD

class BaseViewController: UIViewController, CommonViewProtocol {
    var screenName: String {
        return "Base"
    }

    var className: String {
        return String(describing: type(of: self))
    }

    // whether it is contained in a modal
    var inModal: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController.navigationBar.shadowImage = UIImage()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }

    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Prevent loading display on screen that is not displayed
            if self.isVisible(view: self.view) == false {
                return
            }
            if NetworkManager.shared.isNetworkAvaiable {
                ProgressHUD.colorAnimation = .systemBlue
                ProgressHUD.animationType = .circleRotateChase
                ProgressHUD.show(nil, interaction: false)
            }
        }
    }

    func finishLoading(completion: (() -> Void)? = nil) {
        guard isVisible(view: view) else { return }
        ProgressHUD.dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !ProgressHUD.isVisibleError && !ProgressHUD.isVisibleSuccess {
                completion?()
            }
        }
    }

    func showFailed(_ message: String?) {
        if message != nil {
            log(message!)
        }
        ProgressHUD.isVisibleError = true
        ProgressHUD.colorAnimation = .systemGray
        ProgressHUD.showFailed(message, interaction: false, delay: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ProgressHUD.isVisibleError = false
        }
    }

    func showError(_ message: String?) {
        if message != nil {
            log(message!)
        }
        ProgressHUD.isVisibleError = true
        ProgressHUD.showError(message, image: nil, interaction: false, delay: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ProgressHUD.isVisibleError = false
        }
    }

    func showSuccess(_ message: String?) {
        if message != nil {
            log(message!)
        }
        ProgressHUD.isVisibleSuccess = true
        ProgressHUD.showSuccess(message, image: nil, interaction: false, delay: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ProgressHUD.isVisibleSuccess = false
        }
    }

    private func isVisible(view: UIView) -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(view.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: view, inView: view.superview)
    }
}

extension ProgressHUD {
    static var isVisibleError = false
    static var isVisibleSuccess = false
}
