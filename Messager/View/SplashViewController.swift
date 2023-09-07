//
//  SplashViewController.swift
//  Messager
//
//  Created by Kim Phong on 04/07/2023.
//

import UIKit

class SplashViewController: BaseViewController {
    @IBOutlet var splashView: UIView!
    var presenter: SplashPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)

        splashView.alpha = 0.0
        showAnimation { [weak self] in
            self?.presenter.checkLogin()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // TODO: check network
    }

    func showAnimation(handler: @escaping () -> Void) {
        UIView.animate(withDuration: 1.5) {
            self.splashView.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: 2.0) {
                self.splashView.alpha = 0.0
            } completion: { _ in
                handler()
            }
        }
    }
    
}

extension SplashViewController: SplashView {}
