//
//  APIUrls.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/11.
//

import Foundation
struct APIUrls {
    static let baseURL = "http://3.38.20.217:3000/api/"
    
    // auth
    static let postSigninURL = baseURL + "auth/login"
    static let postSignupURL = baseURL + "auth/signup"
    static let getCheckEmailURL = baseURL + "auth/check-email/"
    static let getSendAuthEmailURL = baseURL + "auth/mail/"
    static let getAuthEmailURL = baseURL + "auth/mail"
    
    // profile
    static let getMyProfileURL = baseURL + "profile" // 내 프로필 조회
    static let getProfileURL = baseURL + "profile/" // 다른 사람 프로필 조회
    static let postUpdateProfileURL = baseURL + "profile" // 내 프로필 수정
    
    // home
    static let getMyStoryURL = baseURL + "user/story" // 내 스토리 조회
    static let getMyStoryTagsURL = baseURL + "user/tags" // 내 태그 목록 조회
    static let getMySearchedStoryURL = baseURL + "user/page" // 내 태그별 스토리 조회

    
    static let getStoryURL = baseURL + "user/" // 남 스토리 조회 {userId}/story
    static let getStoryTagsURL = baseURL + "user/" // 남 태그 목록 조회 /api/user/{userId}/tags
    
    // upload
    static let uploadProfileImageURL = baseURL + "upload/profile" // 프로필 이미지 업로드
    static let uploadPageImagesURL = baseURL + "upload/page" // 페이지 이미지 업로드
    
    // tag
    static let getRecomTagURL = baseURL + "profile/tags/recommend" // 추천 태그 조회
    static let postSetProfileTagsURL = baseURL + "profile/tags" // 프로필 태그 설정
    static let postAddTagURL = baseURL + "tags" // 태그 추가
    static let postAddColorTagURL = baseURL + "tags/color" // 컬러 태그 추가

    // project
    static let getColorsURL = baseURL + "project/colors" // 색 목록 조회
    static let postCreateProjectURL = baseURL + "project" // 프로젝트 생성
    static let postUpdateProjectURL = baseURL + "project/" // 프로젝트 수정
    static let delProjectURL = baseURL + "project/" // 프로젝트 삭제
    static let getProjectDetailURL = baseURL + "project/" // 프로젝트 상세 조회

    // page
    static let postCreatePageURL = baseURL + "page" // 페이지 생성
    static let postUpdatePageURL = baseURL + "page/" // 페이지 수정
    static let delPageURL = baseURL + "page/" // 페이지 삭제
    static let getPageURL = baseURL + "page/" // 페이지 상세 조회
    

    // exp
    static let getRecomPageURL = baseURL + "explore/page/recommend" // 추천페이지목록조회
    static let searchPageURL = baseURL + "explore/page" // 페이지 검색
    static let searchProfileURL = baseURL + "explore/user" // 프로필 검색
    
    // like
    static let getLikePageURL = baseURL + "like/page" // 좋아요한 페이지 목록
    static let getLikeProfileURL = baseURL + "like/user" // 좋아요한 프로필 목록



}
