//
//  PageDetailData.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/26.
//
import Foundation
struct PageDetailData: Codable {
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
    var images: [String]
    var imageCount: Int?
    var tags: [TagData?]
    var projectColor: String?
}
