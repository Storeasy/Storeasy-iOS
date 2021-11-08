//
//  User.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import Foundation

struct User: Codable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
