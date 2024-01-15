//
//  ErrorResponseModel.swift
//  Workspace
//
//  Created by 김하은 on 1/9/24.
//

import Foundation

struct ErrorResponseModel: Decodable, Error {
    let errorCode: String
}
