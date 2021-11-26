//
//  ProjectDetailResponse.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/26.
//

import Foundation
// 프로젝트 상세 조회
struct ProjectDetail: Codable {
    var project: Project
    var pages: [PageInProject]
}
