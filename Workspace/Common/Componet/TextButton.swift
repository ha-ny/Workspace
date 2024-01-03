//
//  TextButton.swift
//  Workspace
//
//  Created by 김하은 on 1/3/24.
//

import UIKit

final class TextButton: UIButton {
    
    enum ButtonType {
        case active
        case inActive
        case border
    }

    init(style: ButtonType, title: String) {
        super.init(frame: .zero)
        
        titleLabel?.font = .title2
        layer.cornerRadius = 8
        setTitle(title, for: .normal)
        
        switch style {
        case .active, .inActive:
            setTitleColor(.bdWhite, for: .normal)
            backgroundColor = .bdGreen
        case .border:
            setTitleColor(.bdBlack, for: .normal)
            backgroundColor = .bdWhite
            layer.borderWidth = 1
            layer.borderColor = UIColor.bdBlack.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


