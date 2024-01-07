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
    
    let signButton: UIButton = {
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
        addSubview(signButton)
    }
    
    override func setConstraints() {
        let views = [appleButton, kakaoButton, emailButton, signButton]
        
        views.enumerated().forEach { index, view in
            view.snp.makeConstraints {
                if index == 0 {
                    $0.top.equalToSuperview().inset(42)
                    $0.horizontalEdges.equalToSuperview().inset(35)
                } else {
                    $0.horizontalEdges.equalTo(views[index - 1].snp.horizontalEdges)
                    $0.top.equalTo(views[index - 1].snp.bottom).offset(16)
                }
            }
        }
    }
}
