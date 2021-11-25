//
//  PostProfileTagsService.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import Foundation
import Alamofire

struct PostProfileTagsService {
    
    static let shared = PostProfileTagsService()
    
    func postProfileTags (accessToken: String, tagIds: [Int], completionHandler: @escaping (ResponseCode, Any) -> (Void)) {

        let url = APIUrls.postSetProfileTagsURL
        let header: HTTPHeaders = [ "Content-Type": "application/json"
                                    ,"Authorization": accessToken]
        let body: Parameters = [
            "tags" : tagIds
        ]
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: header).responseData { (response) in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let body =  response.value else { return }
                
                // 상태 코드 처리
                var responseCode: ResponseCode = .success
                if status == 201 {
                    print("성공")
                    responseCode = .success
                } else {
                    print("실패")
                    print(response)
                    responseCode = .serverError
                }
                
                // response body 파싱
                let decoder = JSONDecoder()
                guard let responseBody = try? decoder.decode(ResponseData<String>.self, from: body) else { return }
                
                // 응답 결과 전송
                completionHandler(responseCode, responseBody)
            case .failure(let error):
                print(error)
                completionHandler(.requestError, "request fail")
            }
        }
        
    }
    
    
}
