//
//  EmailLoginView.swift
//  Workspace
//
//  Created by 김하은 on 1/5/24.
//

import UIKit

final class EmailLoginView: BaseView {

    let navigationView = ModalNavigationView(title: "이메일 로그인")
    let emailView = TextFieldView(title: "이메일", placeholder: "이메일을 입력하세요")
    let passwordView = TextFieldView(title: "비밀번호", placeholder: "비밀번호를 입력하세요")
    
    let loginButtonView = {
        let view = TextButtonView(style: .fill, title: "로그인")
        view.button.backgroundColor = .bdInactive
        return view
    }()
    
    override func setConfiguration() {
        addSubview(navigationView)
        addSubview(emailView)
        addSubview(passwordView)
        addSubview(loginButtonView)
    }
    
    override func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        emailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(navigationView.snp.bottom).offset(24)
        }
        
        passwordView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(emailView.snp.bottom).offset(24)
        }
        
        loginButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
        }
    }
}
