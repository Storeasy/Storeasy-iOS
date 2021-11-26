//
//  PageInProject.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/26.
//

//프로젝트 상세
//"pages":[{"userId":16,"profileImage":null,"nickname":null,"isPublic":true,"isLiked":false,"projectId":null,"projectTitle":null,"pageId":12,"title":"앱 서비스의 사용자 방법론","content":"서비스 개발을 할 때 항상 고민되는 지점이 과연 어떤 게 사용자에게...","startDate":"2020-04-12","endDate":"2020-04-12","imageCount":0,"images":null,"tags":[{"id":20,"tagName":"기획","tagColor":"tag_blue"},{"id":39,"tagName":"학교","tagColor":"tag_red"},{"id":42,"tagName":"앱개발","tagColor":"tag_pink"}]}

import Foundation
struct PageInProject: Codable {
    var userId: Int?
    var isPublic: Bool?
    var isLiked: Bool?
    var pageId: Int?
    var title: String?
    var content: String?
    var startDate: String?
    var endDate: String?
    var imageCount: Int?
    var tags: [TagData?]
}
