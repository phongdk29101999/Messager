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

    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Prevent loading display on screen that is not displayed
            if self.isVisible(view: self.view) == false {
                return
            }
            if NetworkManager.shared.isNetworkAvaiable {
                ProgressHUD.show()
            }
        }
    }

    func finishLoading(completion: (() -> Void)? = nil) {
        guard isVisible(view: view) else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !ProgressHUD.isVisibleError {
                ProgressHUD.dismiss()
            }
        }
    }

    func showError(_ message: String) {
        ProgressHUD.showError(message)
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

private extension ProgressHUD {
    static var isVisibleError: Bool = false
}
