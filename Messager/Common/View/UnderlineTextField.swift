//
//  UnderlineTextField.swift
//  Messager
//
//  Created by Kim Phong on 22/06/2023.
//

import Foundation
import UIKit
import SnapKit

class UnderlineTextField: DesignableTextField {
    @IBInspectable var underlineColor: UIColor = .clear

    // Create UIView for underline
    let underline = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        composeUnderline()
    }

    private func configure() {
        self.addSubview(underline)
        underline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    private func composeUnderline() {
        underline.backgroundColor = underlineColor
        bringSubviewToFront(underline)
    }
}
