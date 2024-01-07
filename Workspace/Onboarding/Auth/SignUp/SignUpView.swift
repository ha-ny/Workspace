//
//  SignUpView.swift
//  Workspace
//
//  Created by 김하은 on 1/3/24.
//

import UIKit

final class SignUpView: BaseView {

    let navigationView = NavigationView(title: "회원가입")
    let emailView = TextFieldView(title: "이메일", placeholder: "이메일을 입력하세요")
    
    let emailCheckButton = {
        let view = TextButtonView(style: .fill, title: "중복 확인").button
        view.backgroundColor = .bdInactive
        return view
    }()
    
    let nickNameView = TextFieldView(title: "닉네임", placeholder: "닉네임을 입력하세요")
    let phoneView = TextFieldView(title: "연락처", placeholder: "전화번호를 입력하세요")
    
    let passwordView = {
        let view = TextFieldView(title: "비밀번호", placeholder: "비밀번호를 입력하세요")
        view.textField.isSecureTextEntry = true
        return view
    }()
    
    let passwordCheckView = {
        let view = TextFieldView(title: "비밀번호 확인", placeholder: "비밀번호를 한 번 더 입력하세요")
        view.textField.isSecureTextEntry = true
        return view
    }()

    let signUpButtonView = {
        let view =  TextButtonView(style: .fill, title: "가입하기")
        view.button.backgroundColor = .bdInactive
        return view
    }()
    
    func activeEmailCheckButton(isActive: Bool) {
        emailCheckButton.isEnabled = isActive
        emailCheckButton.backgroundColor = isActive ? .bdGreen : .bdInactive
    }
    
    override func setConfiguration() {
        addSubview(navigationView)
        addSubview(emailView)
        addSubview(emailCheckButton)
        addSubview(nickNameView)
        addSubview(phoneView)
        addSubview(passwordView)
        addSubview(passwordCheckView)
        addSubview(signUpButtonView)
    }
    
    override func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
        }

        let views = [emailView, nickNameView, phoneView, passwordView, passwordCheckView]
        
        views.enumerated().forEach { index, view in
            view.snp.makeConstraints {
                if index == 0 {
                    $0.top.equalTo(navigationView.snp.bottom).offset(24)
                    $0.leading.equalTo(24)
                } else {
                    $0.top.equalTo(views[index - 1].snp.bottom).offset(24)
                    $0.horizontalEdges.equalToSuperview().inset(24)
                }
            }
        }
        
        emailCheckButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.bottom.equalTo(emailView.textField.snp.bottom)
            $0.leading.equalTo(emailView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        signUpButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
        }
    }
}
