//
//  PageData.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/26.
//

import Foundation
struct PageData: Codable {
    var userId: Int?
    var isPublic: Bool?
    var isLiked: Bool?
    var projectId: Int?
    var projectTitle: String?
    var pageId: Int?
    var title: String?
    var content: String?
    var startDate: String?
    var endDate: String?
    var imageCount: Int?
    var tags: [TagData?]
}
