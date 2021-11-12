//
//  ProfileData.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/12.
//

import Foundation
//{
//  "userId": 1,
//  "profileImage": "http://어쩌구저쩌구",
//  "nickname": "testnickname",
//  "universityName": "성신여자대학교",
//  "contact": "test@test.com",
//  "bio": "안녕하세요. 저는 어쩌구저쩌구",
//  "tags": [
//    "{ \"id\": 1, \"tagName\": \"울랄라\", \"tagColor\": \"#123456\" }"
//  ]
//}

struct ProfileData: Codable {
    let userId: Int?
    let profileImage: String?
    let nickname: String?
    let universityName: String?
    let contact: String?
    let bio: String?
    let tags: [TagData?]
}
