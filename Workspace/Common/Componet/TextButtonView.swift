//
//  TextButtonView.swift
//  Workspace
//
//  Created by 김하은 on 1/7/24.
//

import UIKit

final class TextButtonView: BaseView {
    
    lazy var button = {
        let view = UIButton()
        view.titleLabel?.font = .title2
        view.layer.cornerRadius = 8
        return view
    }()
    
    enum ButtonType {
        case fill
        case border
    }

    init(style: ButtonType, title: String) {
        super.init(frame: .zero)
    
        button.setTitle(title, for: .normal)
        
        switch style {
        case .fill:
            button.setTitleColor(.bdWhite, for: .normal)
            button.backgroundColor = .bdGreen
        case .border:
            button.setTitleColor(.bdBlack, for: .normal)
            button.backgroundColor = .bdWhite
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.bdBlack.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConfiguration() {
        addSubview(button)
    }
    
    override func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(68)
        }
        
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(44)
        }
    }
}
