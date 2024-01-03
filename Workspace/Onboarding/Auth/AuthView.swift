//
//  AuthView.swift
//  Workspace
//
//  Created by 김하은 on 1/3/24.
//

import UIKit

final class AuthView: BaseView {

    let appleButton = ImageButton(image: .appleLogin)
    let kakaoButton = ImageButton(image: .kakaoLogin)
    let emailButton = ImageButton(image: .emailLogin)
    
    let joinButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = .title2
        view.setTitleColor(.bdGreen, for: .normal)
        
        let attributedString = NSMutableAttributedString(string: "또는 새롭게 회원가입 하기")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.bdBlack,
                                      range: NSRange(location: 0, length: 2))
            
        view.setAttributedTitle(attributedString, for: .normal)
        return view
    }()

    
    override func setConfiguration() {
        addSubview(appleButton)
        addSubview(kakaoButton)
        addSubview(emailButton)
        addSubview(joinButton)
    }
    
    override func setConstraints() {
        appleButton.snp.makeConstraints {
            $0.top.equalTo(self).inset(42)
            $0.horizontalEdges.equalTo(self).inset(35)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(appleButton.snp.horizontalEdges)
            $0.top.equalTo(appleButton.snp.bottom).offset(16)
        }
        
        emailButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(kakaoButton.snp.horizontalEdges)
            $0.top.equalTo(kakaoButton.snp.bottom).offset(16)
        }
        
        joinButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(emailButton.snp.horizontalEdges)
            $0.top.equalTo(emailButton.snp.bottom).offset(16)
        }
    }
}
