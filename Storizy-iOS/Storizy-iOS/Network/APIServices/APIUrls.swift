//
//  APIUrls.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/11.
//

import Foundation
struct APIUrls {
    static let baseURL = "http://3.38.20.217:3000/api/"
    
    static let signinPostURL = baseURL + "auth/login"
    static let signupPostURL = baseURL + "auth/signup"
    static let checkEmailGetURL = baseURL + "auth/check-email/"
    static let sendAuthEmaiGetURL = baseURL + "auth/mail/"
    static let authEmailGetURL = baseURL + "auth/mail"
    
    static let recomTagGetURL = baseURL + "profile/tags/recommend" // 추천 태그 조회
    static let setProfileTagsPostURL = baseURL + "profile/tags" // 프로필 태그 설정
    
    static let addTagPostURL = baseURL + "tags" // 태그 추가


}
