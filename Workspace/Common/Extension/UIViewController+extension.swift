//
//  UIViewController+extension.swift
//  Workspace
//
//  Created by 김하은 on 1/7/24.
//

import UIKit

extension UIViewController {
    func toastMessage(title: String, centerView: UIView) {
        let view =  TextButtonView(style: .fill, title: title).button
        view.titleLabel?.font = .body
        view.sizeToFit()
        self.view.addSubview(view)
        
        view.snp.removeConstraints()
        
        view.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: view.frame.width + 40, height: 36))
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(centerView.snp.top)
        }
        
        UIView.animate(withDuration: 3) {
            view.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 3, delay: 0.5) {
                view.alpha = 0
            } completion: { _ in
                view.removeFromSuperview()
            }
        }
    }
}
