//
//  CommonPresenter.swift
//  Messager
//
//  Created by Kim Phong on 22/06/2023.
//

import Foundation

protocol CommonViewProtocol: AnyObject {
    func startLoading()
    func finishLoading()
    func finishLoading(completion: (() -> Void)?)
    func showError(_ message: String)
}

extension CommonViewProtocol {
    func finishLoading() {
        finishLoading(completion: nil)
    }
}
