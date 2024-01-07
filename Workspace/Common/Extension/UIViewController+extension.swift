//
//  UIViewController+extension.swift
//  Workspace
//
//  Created by 김하은 on 1/7/24.
//

import UIKit

extension UIViewController {
    
    enum Detent {
        case large
        case medium
        case custom(CGFloat)
    }
    
    func bottomSheet(view: UIViewController, detent: Detent, isGrab: Bool = false){
        guard let sheet = view.sheetPresentationController else { return }
        
        var detents: UISheetPresentationController.Detent {
            switch detent {
            case .large: return .large()
            case .medium: return .medium()
            case .custom(let num):
                return .custom(resolver: { _ in num })
            }
        }

        sheet.detents = [detents]
        sheet.preferredCornerRadius = 10
        sheet.prefersGrabberVisible = isGrab
        
        self.present(view, animated: true)
    }
}
