//
//  ProfileData.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/12.
//

import Foundation

struct ProfileData: Codable {
    let userId: Int?
    var isPublic: Bool?
    var profileImage: String?
    var nickname: String?
    var universityName: String?
    var contact: String?
    var bio: String?
    var tags: [TagData]
}
