//
//  TextFieldView.swift
//  Workspace
//
//  Created by 김하은 on 1/3/24.
//

import UIKit

final class TextFieldView: BaseView {
    
    private lazy var label = {
       let view = UILabel()
        view.font = .title2
        view.textColor = .bdBlack
        return view
    }()
    
    lazy var textField = {
       let view = UITextField()
        view.font = .body
        view.textColor = .bdBlack
        view.layer.cornerRadius = 8
        view.backgroundColor = .bgSecondary
        view.tintColor = .bdGreen
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        view.leftViewMode = .always
        return view
    }()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        label.text = title
        textField.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConfiguration() {
        addSubview(label)
        addSubview(textField)
    }
    
    override func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(76)
        }
        
        label.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(label)
            $0.height.equalTo(44)
        }
    }
}
