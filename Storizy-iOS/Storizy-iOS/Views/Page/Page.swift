//
//  Page.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import Foundation

struct Page: Codable {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
