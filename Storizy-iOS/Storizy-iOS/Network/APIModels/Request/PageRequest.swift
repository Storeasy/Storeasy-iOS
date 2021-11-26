//
//  PageRequest.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import Foundation
//{
//    "title": "룰루랄라!",
//    "content": "마지막 페이지! 취업 성공! 안녕!",
//    "startDate": "2021-11-20",
//    "endDate": "2021-11-20",
//    "isPublic": true,
//    "projectId": 2,
//    "tagIds": [32, 34],
//    "pageImages": ["http://", "http://~"]
//}

struct PageRequest: Codable {
    var title: String?
    var content: String?
    var startDate: String?
    var endDate: String?
    var isPublic: Bool?
    var projectId: Int?
    var tagIds: [Int?]
    var pageImages: [String?]
}
