//
//  ProjectResponse.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import Foundation
//{"project":{"userId":16,"isPublic":true,"projectId":11,"projectColor":"tag_pink","title":"오늘의 옷장","description":"날씨에 맞는 옷차림 추천 APP 디자인 참여","startDate":"2021-10-04","endDate":"2021-11-17","tags":[{"id":39,"tagName":"학교","tagColor":"tag_red"},{"id":42,"tagName":"앱개발","tagColor":"tag_pink"}]
// 페이지 상세 조회
struct Project: Codable {
    var userId: Int?
    var isPublic: Bool?
    var projectId: Int?
    var projectColor: String?
    var title: String?
    var description: String?
    var startDate: String?
    var endDate: String?
    var tags: [TagData]
}
