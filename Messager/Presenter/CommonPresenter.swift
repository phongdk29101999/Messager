//
//  CommonPresenter.swift
//  Messager
//
//  Created by Kim Phong on 22/06/2023.
//

import Foundation
import ProgressHUD

protocol CommonViewProtocol: AnyObject {
    func startLoading()
    func finishLoading()
    func finishLoading(completion: (() -> Void)?)
    func showError(_ message: String?)
    func showSuccess(_ message: String?)
    func showFailed(_ message: String?)
}

extension CommonViewProtocol {
    func finishLoading() {
        finishLoading(completion: nil)
    }
}

protocol CommonPresenterProtocol {
    func attachView(_ view: CommonViewProtocol)
    func detachView()
    func finishWithError(_ message: String)
    func finishWithFail(_ message: String)
}

class CommonPresenter: CommonPresenterProtocol {
    fileprivate weak var _view: CommonViewProtocol?

    open var view: CommonViewProtocol? {
        return _view
    }

    init() {}

    func attachView(_ view: CommonViewProtocol) {
        _view = view
    }

    func detachView() {
        _view = nil
    }

    func finishWithError(_ message: String) {
        _view?.showError(message)
    }

    func finishWithFail(_ message: String) {
        _view?.showFailed(message)
    }
}
