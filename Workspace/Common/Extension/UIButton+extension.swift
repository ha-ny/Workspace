//
//  UIButton+extension.swift
//  Workspace
//
//  Created by 김하은 on 1/16/24.
//

import UIKit

extension UIButton {
    func activeState(isActive: Bool) {
        self.isEnabled = isActive
        self.backgroundColor = isActive ? .bdGreen : .bdInactive
    }
}
