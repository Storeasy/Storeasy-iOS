//
//  CreateProjectRequestDto.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import Foundation

//{
//    "title": "스토리지",
//    "description": "대학생을 위한 경험관리 앱",
//    "startDate": "2021-11-01",
//    "endDate": "2021-11-14",
//    "isPublic": true,
//    "projectColorId": 1,
//    "tagIds": [1, 2, 3]
//}

struct ProjectRequest : Codable {
    var title: String?
    var description: String?
    var startDate: String?
    var endDate: String?
    var isPublic: Bool?
    var projectColorId: Int?
    var tagIds: [Int?]
}
