//
//  HomeEmptyView.swift
//  Workspace
//
//  Created by 김하은 on 1/17/24.
//

import UIKit

final class HomeEmptyView: BaseView {

    let navigationView = {
        let view = HomeNavigationView()
        view.backgroundColor = .bgSecondary
        return view
    }()
    
    private let emptyMessage = {
        let view = UILabel()
        view.text = "워크스페이스를 찾을 수 없어요"
        view.textColor = .bdBlack
        view.textAlignment = .center
        view.font = .title1
        return view
    }()
    
    private let emptyMessageBody = {
        let view = UILabel()
        view.text = "관리자에게 초대를 요청하거나, 다른 이메일로 시도하거나\n새로운 워크스페이스를 생성해주세요"
        view.textColor = .bdBlack
        view.textAlignment = .center
        view.font = .body
        view.numberOfLines = 0
        return view
    }()

    private let emptyImage = {
       let view = UIImageView()
        view.image = .notFound
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let createButton = TextButtonView(style: .fill, title: "워크스페이스 생성").button

    override func setConfiguration() {
        addSubview(navigationView)
        addSubview(emptyMessage)
        addSubview(emptyMessageBody)
        addSubview(emptyImage)
        addSubview(createButton)
    }
    
    override func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        emptyMessage.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(35)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        emptyMessageBody.snp.makeConstraints {
            $0.top.equalTo(emptyMessage.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        emptyImage.snp.makeConstraints {
            $0.top.equalTo(emptyMessageBody.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(emptyImage.snp.width)
        }
        
        createButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
