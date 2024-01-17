//
//  String+extension.swift
//  Workspace
//
//  Created by 김하은 on 1/16/24.
//

import Foundation

extension String {
    func isRegexValid(regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
