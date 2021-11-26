//
//  PageResponse.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import Foundation

//"data": {
//        "userId": 1,
//        "isPublic": true,
//        "isLiked": false,
//        "projectId": 3,
//        "projectTitle": "스토리지",
//        "pageId": 3,
//        "title": "스토리지 팀과제 발표",
//        "content": "다가오는 '위드 코로나', 대학생활을 위한 앱을 개발하라!",
//        "startDate": "2021-10-27",
//        "endDate": "2021-10-27",
//        "images": [],
//        "tags": [
//            {
//                "id": 6,
//                "tagName": "해,커리어",
//                "tagColor": "tag_pink"
//            }
//        ]
//    }

struct Page: Codable {
    var userId: Int?
    var profileImage: String?
    var nickname: String?
    var isPublic: Bool?
    var isLiked: Bool?
    var projectId: Int?
    var projectTitle: String?
    var pageId: Int?
    var title: String?
    var content: String?
    var startDate: String?
    var endDate: String?
    var images: [String?]
    var imageCount: Int?
    var tags: [TagData?]
}
