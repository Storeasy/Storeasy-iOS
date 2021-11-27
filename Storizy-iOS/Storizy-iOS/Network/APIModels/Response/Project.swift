//
//  ProjectResponse.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import Foundation
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
