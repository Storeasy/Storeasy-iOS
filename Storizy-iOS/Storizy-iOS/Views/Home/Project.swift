//
//  Project.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import Foundation

struct Project: Codable {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
