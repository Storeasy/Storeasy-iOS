//
//  TagData.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/12.
//

import Foundation

struct TagData: Codable {
    let id: Int?
    let tagName: String?
    let tagColor: String?
}

//"{ \"id\": 1, \"tagName\": \"울랄라\", \"tagColor\": \"#123456\" }"
